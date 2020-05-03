class Store < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :addresses, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  validates :description, presence: true

  mount_uploader :top_image, ImageUploader

  after_validation :geocode

  private
  def geocode
    cgi = CGI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=#{ENV['GOOGLE_MAP_KEY']}")
    res = HTTP.get(cgi).to_s
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
