# frozen_string_literal: true

require "rails_helper"

RSpec.describe IssueSerializer, type: :serializer do
  subject { JSON.parse(serialization.to_json) }

  let(:issue) { create(:issue) }
  let(:serializer) { IssueSerializer.new(issue) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  it { is_expected.to have_key("number") }
  it { is_expected.to have_key("title") }
  it { is_expected.to have_key("state") }
  it { is_expected.to have_key("body") }
  it { is_expected.to have_key("created_at") }
  it { is_expected.to have_key("updated_at") }

  context "if the Issue is assigned to a User" do
    let(:issue) { create(:issue, :assigned) }

    it { is_expected.to have_key("user") }

    it { expect(subject["user"]).to have_key("login") }
    it { expect(subject["user"]).to have_key("avatar_url") }
    it { expect(subject["user"]).to have_key("type") }
    it { expect(subject["user"]).to have_key("url") }
  end
end
