class Linenonce < ApplicationRecordss
  has_one :user, class_name: "user"

  validates :user_id, presence: true, uniqueness: true
  validates :nonce, presence: true, uniqueness: true
end
