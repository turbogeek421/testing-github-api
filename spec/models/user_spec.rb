# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { build :user }

  it_behaves_like "model with uuid"

  context "factory" do
    it_behaves_like "valid factory"
  end

  context "validation" do
    skip "Validation handled by Github - this app is just storing a local copy of the data"
  end
end
