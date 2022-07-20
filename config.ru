# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
require "rest-client"

# RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]

RestClient::Request.execute(
  method: :get,
  url: 'https://credit.j-payment.co.jp/gateway/gateway_token.aspx',
  proxy: ENV["PROXIMO_URL"]
)

  # puts "status code", res.code
# puts "headers", res.headers
