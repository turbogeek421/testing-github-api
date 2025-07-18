# frozen_string_literal: true

RSpec.shared_examples "valid factory" do
  describe "factory" do
    let(:factory) { FactoryBot.send(:build, described_class.name.gsub("::", "").underscore.to_sym) }

    it "is valid" do
      expect(factory).to be_valid
    end
  end
end
