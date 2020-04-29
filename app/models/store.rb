class Store < ApplicationRecord
  has_many :productions, dependent: :destroy
  has_many :addresses, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  validates :description, presence: true

  mount_uploader :top_image, ImageUploader

  after_validation :geocode
  private
  def geocode
    uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=AIzaSyCMEZHcYpdKtuvZoe6Jy5_8zuVUj8G47co&callback=initMap&language=ja")
    res = HTTP.get(uri).to_s
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
