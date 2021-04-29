class Linenonce < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :nonce, presence: true, uniqueness: true, length: { minimum: 10, maximum: 25}
end
