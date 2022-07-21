require "rest-client"

RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]

# RestClient::Request.execute(
#   method: :get,
#   url: 'https://stg-qr-food-japan-management.herokuapp.com/users',
#   proxy: ENV["PROXIMO_URL"]
# )

  # puts "status code", res.code
# puts "headers", res.headers
