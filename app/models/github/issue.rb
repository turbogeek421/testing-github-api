# frozen_string_literal: true

class Github::Issue < Flexirest::Base
  base_url Rails.configuration.x.github_api_url
  request_body_type :json

  before_request :set_headers

  get :updated_since,
      "/repos/turbogeek421/testing-github-api/issues?state=all&sort=updated&since=:date&per_page=100&page=:page",
      requires: %i[date page]

  private
    def set_headers(_name, request)
      request.headers["Accept"] = "application/vnd.github+json"
    end
end
