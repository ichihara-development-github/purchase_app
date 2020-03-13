class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(followed: params[:followed_id])
    current_user.remove(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
