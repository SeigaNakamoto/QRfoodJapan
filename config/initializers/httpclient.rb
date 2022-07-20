require 'httpclient'

class ApiClient
  def execute()
    proxy = ENV["FIXIE_URL"]
    # proxy を指定
    HTTPClient.new(proxy)
    # http://ip-api.com/json/ にリクエストすることでIPを確認
    result = client.get('http://ip-api.com/json/')
  end
end
