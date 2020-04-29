class Store < ApplicationRecord
  has_many :productions, dependent: :destroy
  has_many :addresses, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  validates :description, presence: true

  mount_uploader :top_image, ImageUploader

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
