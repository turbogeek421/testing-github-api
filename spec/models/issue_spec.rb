# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issue, type: :model do
  subject { build :issue }

  it_behaves_like "model with uuid"

  context "factory" do
    it_behaves_like "valid factory"

    context "user assigned" do
      let(:factory) { build :issue, :assigned }

      it { expect(factory).to be_valid }
      it { expect(factory.user).to be_a(User) }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:user).optional }
  end

  context "validation" do
    skip "Validation handled by Github - this app is just storing a local copy of the data"
  end
end
