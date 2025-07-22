# frozen_string_literal: true

require "clockwork"
require "./config/boot"
require "./config/environment"

module Clockwork
  handler do |job, _time|
    job.perform_later
  end
end
