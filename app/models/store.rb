class Store < ApplicationRecord
    has_many :productions, dependent: :destroy
    belongs_to :user
    
  validates :name, presence: true, uniqueness: true, length: {minimum: 1}
  validates :description, presence: true
  validates :top_image, presence: true
  
  mount_uploader :top_image, ImageUploader
end
