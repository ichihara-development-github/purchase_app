require 'net/http'
require 'uri'

class Line
  TOKEN = ENV["LINE_TOKEN"]
  URL = "https://notify-api.line.me/api/notify".freeze

  attr_reader :notice

  def self.send(notice)
    new(notice).send
  end

  def initialize(notice)
    @notice = notice
  end

  def send
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |https|
      https.request(request)
    end
  end

  private

  def request
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{TOKEN}"
    request.set_form_data(message: notice)
    request
  end

  def uri
    URI.parse(URL)
  end
end
