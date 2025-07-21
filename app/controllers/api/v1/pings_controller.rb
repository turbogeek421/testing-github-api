# frozen_string_literal: true

class API::V1::PingsController < APIController
  def index
    ping_response = {
      pong: "ok",
      ip: request.remote_ip
    }
    render(json: ping_response, status: :ok)
  end
end
