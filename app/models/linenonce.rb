class Linenonce < ApplicationRecordss
  has_one :user, class_name: "User"

  validates :user_id, presence: true, uniqueness: true
  validates :nonce, presence: true, uniqueness: true
end
