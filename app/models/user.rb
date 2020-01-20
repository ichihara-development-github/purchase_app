class User < ApplicationRecord
  has_one :store, dependent: :destroy, class_name: Store
  has_many :payment
  has_many :baskets, dependent: :destroy
  has_many :considering_productions, through: :baskets, source: :production
  has_many :purchaceds, dependent: :nullify
  has_many :purchaced_productions, through: :purchaceds, source: :production
  
  has_many :comments, dependent: :destroy
  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, presence: true, uniqueness: true, length: { minimum: 1}
  validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: { minimum: 6}
  
  mount_uploader :profile_image, ImageUploader
  
end
