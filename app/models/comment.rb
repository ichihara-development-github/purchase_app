class Comment < ApplicationRecord


  IMAGE_PATH = "https://purchase-app-backet.s3.amazonaws.com"

  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: { maximum: 100}
end
