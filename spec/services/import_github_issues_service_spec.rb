# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImportGithubIssuesService do
  subject { described_class.new(date) }

  let(:date) { 1.day.ago }
  let(:github_user_data) {
    double("GithubUserData",
      login: "user-login",
      avatar_url: "user-avatar_url",
      type: "user-type",
      url: "user-url"
    )
  }
  let(:github_issue_number) { 123 }
  let(:github_issue_data) {
    double("GithubIssueData",
      number: github_issue_number,
      title: "issue-title",
      body: "issue-body",
      state: "issue-state",
      assignee: github_user_data
    )
  }
  let(:data_set) { double(items: [github_issue_data]) }
  let(:empty_data_set) { double(items: []) }

  before do
    allow(Github::Issue).to receive(:updated_since).and_return(data_set, empty_data_set)
  end

  it "fetches issue data from Github" do
    expect(Github::Issue).to receive(:updated_since)
      .with(date:, page: anything)
      .and_return(data_set, empty_data_set)
    subject.call
  end

  context "processing Github issue data" do
    # Scenarios
    #   Issue exists
    #     - GitHub issue is assigned
    #       - Issue assigned to same user
    #       - Issue assigned to different user
    #       - Issue unassigned
    #     - GitHub issue is not assigned
    #       - Issue assigned
    #       - Issue unassigned
    #     - GitHub issue different state
    #   Issue does not exist
    #     - GitHub issue is assigned
    #     - GitHub issue is not assigned
    context "if an Issue record exists" do
      let!(:issue) { create(:issue, number: github_issue_number) }

      it "does not create a new Issue record" do
        expect { subject.call }.to_not change(Issue, :count)
      end

      it "updates the existing Issue record" do
        subject.call
        issue.reload
        expect(issue.title).to eq(github_issue_data.title)
        expect(issue.body).to eq(github_issue_data.body)
        expect(issue.state).to eq(github_issue_data.state)
      end

      context "if the Github Issue is assigned" do
        context "if a record for the assigned User does not exist" do
          it "creates a new User record" do
            expect { subject.call }.to change(User, :count).by(1)
          end

          it "updates the User associated with the Issue" do
            expect { subject.call }.to change { issue.reload.user_id }
          end
        end

        context "if a record for the assigned User already exists" do
          let!(:user) { create(:user, login: github_user_data.login) }

          context "but the Issue is not assigned to the User" do
            it "does not create a new User record" do
              expect { subject.call }.to_not change(User, :count)
            end

            it "updates the Issue with the User" do
              expect { subject.call }.to change { issue.reload.user_id }.to(user.id)
            end
          end

          context "and the Issue is assigned to the User" do
            before do
              issue.update(user:)
            end

            it "does not create a new User record" do
              expect { subject.call }.to_not change(User, :count)
            end

            it "updates the Issue with the User" do
              expect { subject.call }.to_not change { issue.reload.user_id }
            end
          end
        end

        context "if the Issue is assigned to a different user" do
          let!(:issue) { create(:issue, :assigned, number: github_issue_number) }

          it "updates the User associated with the Issue" do
            expect { subject.call }.to change { issue.reload.user_id }
          end
        end
      end

      context "if the Github Issue is unassigned" do
        let(:github_user_data) { nil }

        it "does not create a new User record" do
          expect { subject.call }.to_not change(User, :count)
        end

        it "does not set a User on the Issue" do
          expect { subject.call }.to_not change { issue.reload.user_id }
        end

        context "if the Issue has an associated User" do
          let!(:issue) { create(:issue, :assigned, number: github_issue_number) }

          it "removes the User from the Issue" do
            expect { subject.call }.to change { issue.reload.user_id }.to(nil)
          end
        end
      end

      context "if the Github Issue is a different state to the Issue record" do
        it "changes the Issue#state" do
          expect { subject.call }.to change { issue.reload.state }.to(github_issue_data.state)
        end
      end
    end

    context "if an Issue record does not exist" do
      it "creates a new Issue record" do
        expect { subject.call }.to change(Issue, :count).by(1)
      end

      context "if a record for the assigned User does not exist" do
        it "creates a new User record" do
          expect { subject.call }.to change(User, :count).by(1)
        end
      end

      context "if a record for the assigned User already exists" do
        let!(:user) { create(:user, login: github_user_data.login) }

        it "does not create a new User record" do
          expect { subject.call }.to_not change(User, :count)
        end

        it "sets the User on the Issue" do
          subject.call
          expect(most_recent_issue.user).to eq(user)
        end
      end

      context "if the Github Issue is unassigned" do
        let(:github_user_data) { nil }

        it "does not create a new User record" do
          expect { subject.call }.to_not change(User, :count)
        end
      end
    end
  end

  context "if no Github issue data is returned" do
    before do
      allow(Github::Issue).to receive(:updated_since).and_return(empty_data_set)
    end

    it "does not create a new Issue record" do
      expect { subject.call }.to_not change(Issue, :count)
    end

    it "does not update any Issue records" do
      expect_any_instance_of(Issue).to_not receive(:update)
      subject.call
    end
  end

  context "if an error is raised on processing of Github issue data" do
    before do
      allow(Issue).to receive(:find_by).and_raise("Error!")
    end

    it "the service handles the error" do
      expect { subject.call }.to_not raise_error
    end
  end

  private
    def most_recent_issue
      Issue.order(created_at: :desc).first
    end
end
