# frozen_string_literal: true

class ImportGithubIssuesService
  def initialize(date)
    @date = date
    @github_issues = []
  end

  def call
    fetch_issues_from_github
    process_github_issues
    true
  rescue
    # Notify error tracking
    false
  end

  private
    attr_accessor :date, :github_issues

    def fetch_issues_from_github
      page = 1

      while
        items = Github::Issue.updated_since(date:, page:).items
        break if items.count == 0

        @github_issues += items
        page += 1
      end
    end

    def process_github_issues
      github_issues.each do |data|
        issue = Issue.find_by(number: data.number)
        issue ? update_issue(issue, data) : create_issue(data)
      rescue
        # Notify error tracking without exiting loop to allow for other records to be created/updated
        next
      end
    end

    def update_issue(issue, data)
      args = {
        title: data.title,
        body: data.body,
        state: data.state,
        updated_at: data.updated_at
      }

      if issue.user&.login != data.assignee&.login
        args[:user_id] = data.assignee.present? ? fetch_user(data)&.id : nil
      end

      issue.update(args)
    end

    def fetch_user(data)
      return unless data.assignee&.login

      User.find_or_create_by(login: data.assignee.login) do |u|
        u.avatar_url = data.assignee.avatar_url
        u.type = data.assignee.type
        u.url = data.assignee.url
      end
    end

    def create_issue(data)
      user = fetch_user(data)
      Issue.create!(
        number: data.number,
        title: data.title,
        body: data.body,
        state: data.state,
        user:,
        created_at: data.created_at,
        updated_at: data.updated_at
      )
    end
end
