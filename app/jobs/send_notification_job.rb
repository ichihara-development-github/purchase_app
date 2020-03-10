class SendNotificationJob < ApplicationJob

  # queue_as :default
  #
  # def perform
  #   ActionCable.server.broadcast "notification_channel", html: render_html
  # end
  #
  # def render_html
  #   user = Notification.last.noticed_user
  #   ApplicationController.renderer.render(partial: "layouts/notifications_count", locals: {current_user: user})
  # end


end
