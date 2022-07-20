require 'rest-client'
RestClient.proxy = ENV["FIXIE_URL"]
response = RestClient.get("http://welcome.usefixie.com")
