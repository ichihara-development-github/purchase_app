class Notification < ApplicationRecord

  default_scope -> {order(created_at: :desc)}

  belongs_to :product, optional: true
  belongs_to :comment, optional: true

  belongs_to :notice_user, class_name: "User", foreign_key: "active_user_id", optional: true
  belongs_to :noticed_user, class_name: "User",foreign_key:  "passive_user_id", optional: true

  validates :active_user_id, presence: true
  validates :passive_user_id, presence: true
  validates :action, presence: true, length: {minimum: 1}

  # after_create_commit {SendNotificationJob.perform_later }
end
