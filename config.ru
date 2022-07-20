# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
require 'rest-client'
RestClient.proxy = ENV["FIXIE_URL"]
response = RestClient.get("http://welcome.usefixie.com")
