if ENV["PROXIMO_URL"]
  require "rest-client"

  RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]
  res = RestClient.get("http://api.someservice.com/endpoint")
end
