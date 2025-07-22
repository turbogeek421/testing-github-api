# frozen_string_literal: true

require "clockwork"
require "./config/boot"
require "./config/environment"

module Clockwork
  handler do |job, _time|
    job.perform_later
  end

  every(10.minutes, "Github::FetchIssuesJob", skip_first_run: true) do
    Github::FetchIssuesJob.perform_later # Default value checks for issues updated within the last 15 minutes
  end
end
