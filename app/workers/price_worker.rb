class PriceWorker
  include Sidekiq::Worker

  require 'net/http'
  require 'uri'
  require 'json'

  TOKEN = "password"
  URL = "https://comparison-products-api-heroku.herokuapp.com"


  def perform(name)
      url = "#{URL}/price/new"
      data = {"name": name, "token": TOKEN}
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.request_uri)
      req.set_form_data(data)
      res = http.request(req)
  end
end
