# frozen_string_literal: true

require "rails_helper"

RSpec.describe Github::FetchIssuesJob, type: :job do
  let(:service) { double("ImportGithubIssuesService", call: true) }

  it "enqueues the job to the queue" do
    ActiveJob::Base.queue_adapter = :test
    expect { described_class.perform_later }.to have_enqueued_job(described_class)
  end

  context "calling the job" do
    let(:datetime) { 15.minutes.ago } # Default

    around do |example|
      Timecop.freeze(Time.current.change(usec: 0)) { example.run }
    end

    it "calls the service to import Github issue data" do
      expect(ImportGithubIssuesService).to receive(:new).with(datetime).and_return(service)
      described_class.perform_now
    end

    context "if given a specific datetime" do
      let(:datetime) { 3.hours.ago }

      it "calls the service to import Github issue data with the given datetime" do
        expect(ImportGithubIssuesService).to receive(:new).with(datetime).and_return(service)
        described_class.perform_now(datetime)
      end
    end
  end
end
