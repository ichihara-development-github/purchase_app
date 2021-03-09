module NotificationsHelper

  def has_unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
    @notifications.any?
  end

  def unchecked_notifications
    current_user.passive_notifications.where(checked: false).count
  end
end
