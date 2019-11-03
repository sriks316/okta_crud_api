require 'uri'
require 'net/http'
class Api::V1::AuthnController < ApplicationController

	def factors
		url = URI("https://dev-254942.okta.com/api/v1/authn/factors/#{params[:factor_id]}/verify")
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		request = Net::HTTP::Post.new(url)
		request["Accept"] = 'application/json'
		request["Content-Type"] = 'application/json'
		request.body = "{\n  \"stateToken\": \"#{params[:stateToken]}\",\n  \"passCode\": \"#{params[:passCode]}\"\n}"
		response = http.request(request)

		Rails.logger.debug("RESPONSE IS #{JSON.parse(response.read_body)}")

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end

	private

	def factor_params
    params.require(:authn).permit(:passCode, :stateToken)
  end
end