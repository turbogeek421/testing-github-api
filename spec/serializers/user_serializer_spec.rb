# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSerializer, type: :serializer do
  subject { JSON.parse(serialization.to_json) }

  let(:user) { create(:user) }
  let(:serializer) { UserSerializer.new(user) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  it { is_expected.to have_key("login") }
  it { is_expected.to have_key("avatar_url") }
  it { is_expected.to have_key("type") }
  it { is_expected.to have_key("url") }
end
