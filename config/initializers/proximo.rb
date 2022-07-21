require "rest-client"

# RestClient.proxy = ENV["PROXIMO_URL"] if ENV["PROXIMO_URL"]


# RestClient::Request.execute(
#   method: :get,
#   url: 'https://stg-qr-food-japan-management.herokuapp.com/users/entry_payment',
#   headers: {params: {agency_id: 'Q01-004'}},
#   proxy: ENV["PROXIMO_URL"]
# )

# RestClient.get 'http://example.com/resource', {params: {id: 50, 'foo' => 'bar'}}

  # puts "status code", res.code
# puts "headers", res.headers

# # RestClient.get('http://example.com/resource') と同じ
# RestClient::Request.execute(method: :get, url: 'http://example.com/resource')

# # オプション指定1
# RestClient::Request.execute(method: :get, url: 'http://example.com/resource',
#                             timeout: 10)

# # オプション指定2
# RestClient::Request.execute(method: :get, url: 'http://example.com/resource',
#                             ssl_ca_file: 'myca.pem',
#                             ssl_ciphers: 'AESGCM:!aNULL')

# # オプション指定3
# RestClient::Request.execute(method: :delete, url: 'http://example.com/resource',
#                             payload: 'foo', headers: {myheader: 'bar'})

# # GET http://example.com/resource?foo=bar
# # クエリパラメータはheadersのparamsに指定する
# RestClient::Request.execute(method: :get, url: 'http://example.com/resource',
#                             timeout: 10, headers: {params: {foo: 'bar'}})
