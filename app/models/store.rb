

class Store < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  validates :description, presence: true

  mount_uploader :top_image, ImageUploader

  geocoded_by :address
  after_validation :geocode


  private
  def geocode
    res = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=AIzaSyAAWezrBjtug-O85xz84V_TYNCmv1pYxDQ")
    response = JSON.parse(res)
    self.latitude = response["results"][0]["geometry"]["location"]["lat"]
    self.longitude = response["results"][0]["geometry"]["location"]["lng"]
  end
end
