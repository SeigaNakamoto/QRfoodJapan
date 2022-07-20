# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
require "rest-client"

RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]

# res = RestClient.get("http://api.someservice.com/endpoint")

# puts "status code", res.code
# puts "headers", res.headers
