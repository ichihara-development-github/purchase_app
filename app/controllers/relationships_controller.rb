class RelationshipsController < ApplicationController

  def create_notification(user)
      notification = current_user.active_notifications.new(
        passive_user_id: user.id,
        action: "フォロー"
      )
        notification.save
  end
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    create_notification(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.remove(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
