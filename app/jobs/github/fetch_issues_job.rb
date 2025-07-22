# frozen_string_literal: true

class Github::FetchIssuesJob < ApplicationJob
  def perform(datetime = 15.minutes.ago)
    ImportGithubIssuesService.new(datetime).call
  end
end
