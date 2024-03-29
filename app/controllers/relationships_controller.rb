class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:followed_id])
    unless current_user == @user
      current_user.follow(@user)
      create_notification(@user,"","","follow")
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
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
