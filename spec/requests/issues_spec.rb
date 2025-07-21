# frozen_string_literal: true

require "rails_helper"

RSpec.describe "API::V1::Issues", type: :request do
  describe "GET /v1/issues" do
    let(:issue1) { create(:issue) }
    let(:issue2) { create(:issue) }
    let(:url) { "/v1/issues" }

    before do
      issue1
      issue2

      get url
    end

    it { expect(response).to have_http_status(:ok) }

    it "response contains all issue data" do
      data = JSON.parse(response.body)
      expect(data.count).to eq(2)
      expect(data.pluck("number")).to include(issue1.number, issue2.number)
    end

    context "if no issues exist" do
      let(:issue1) { nil }
      let(:issue2) { nil }

      it { expect(response).to have_http_status(:ok) }
    end

    context "if an Issue is assigned to a User" do
      let(:issue1) { create(:issue, :assigned) }
      let(:issue2) { nil }

      it "response contains issue user data" do
        data = JSON.parse(response.body)
        expect(data.pluck("user").first).to include("login" => issue1.user.login)
      end
    end

    context "pagination" do
      context "page 1" do
        let(:url) { "/v1/issues?per_page=1" }

        it "response contains expected issue data" do
          data = JSON.parse(response.body)
          expect(data.count).to eq(1)
          expect(data.pluck("number")).to include(issue2.number)
          expect(data.pluck("number")).to_not include(issue1.number)
        end
      end

      context "page 2" do
        let(:url) { "/v1/issues?per_page=1&page=2" }

        it "response contains expected issue data" do
          data = JSON.parse(response.body)
          expect(data.count).to eq(1)
          expect(data.pluck("number")).to include(issue1.number)
          expect(data.pluck("number")).to_not include(issue2.number)
        end
      end
    end

    context "custom headers" do
      it { expect(response.headers).to have_key("X-Issues-Total-Count") }
      it { expect(response.headers).to have_key("X-Issues-Per-Page") }
      it { expect(response.headers).to have_key("X-Issues-Page") }
    end
  end
end
