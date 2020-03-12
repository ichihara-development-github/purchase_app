class NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.paginate(page: params[:page], per_page: 8)
    @notifications.where(checked: false).each do |notification|
    notification.update(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications
    @notifications.destroy_all
    redirect_to notifications_path
  end
end
