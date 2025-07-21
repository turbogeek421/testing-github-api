# frozen_string_literal: true

class API::V1::IssuesController < ApplicationController
  before_action :check_params

  def index
    @issues = paginate(
      fetch_issues,
      page: (params[:page] || 1),
      per_page: (params[:per_page] || 50)
    )
    render json: @issues
  end

  private
    attr_accessor :filter_state

    def check_params
      return unless params[:state].present?

      @filter_state = params[:state]
      return if filter_state.in?(Issue::EXPECTED_STATES)

      error_msg = "State given '#{filter_state}' is not an expected value: #{Issue::EXPECTED_STATES.join(', ')}"
      render json: { error: error_msg }, status: :bad_request
    end

    def fetch_issues
      rel = ::Issue.includes(:user).order(updated_at: :desc)
      return rel unless filter_state

      rel.where(state: filter_state)
    end
end
