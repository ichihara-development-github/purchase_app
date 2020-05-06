

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
    res = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=AIzaSyCMEZHcYpdKtuvZoe6Jy5_8zuVUj8G47co")
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
