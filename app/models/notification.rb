class Notification < ApplicationRecord

  default_scope -> {order(created_at: :desc)}

  belongs_to :production, optional: true
  belongs_to :comment, optional: true

  belongs_to :notice_user, class_name: "User", foreign_key: "active_user_id", optional: true
  belongs_to :noticed_user, class_name: "User",foreign_key:  "passive_user_id", optional: true

  # after_create_commit {SendNotificationJob.perform_later }
end