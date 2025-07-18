# frozen_string_literal: true

RSpec.shared_examples "model with uuid" do
  let(:factory) { FactoryBot.send(:build, described_class.name.gsub("::", "").underscore.to_sym) }

  it "sets a UUID" do
    expect(factory).to receive(:assign_uuid_id).and_call_original
    expect { factory.save }.to change { factory.id }.from(nil).to(anything)
  end
end
