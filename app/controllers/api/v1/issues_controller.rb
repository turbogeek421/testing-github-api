# frozen_string_literal: true

class API::V1::IssuesController < ApplicationController
  def index
    @issues = Issue.includes(:user).order(updated_at: :desc).page(params[:page] || 1).per(params[:per_page] || 50)
    render json: @issues
  end
end
