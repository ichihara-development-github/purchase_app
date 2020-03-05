class CommentsController < ApplicationController

  before_action :login_user?, only: [:create]
  before_action :set_comment, only: [:destroy]
  before_action -> {has_authority?(@comment.user) }, only: [:destroy]

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def create_notification(comment, user)
      notification = user.active_notifications.new(
      comment_id: comment.id,
      active_user_id: current_user.id,
      passive_user_id: user.id
      action: "コメント"
    )
    notification.save
  end



  def create
    @production = Production.find(params[:comment][:id])
    @comments = @production.comments.order(created_at: "DESC")
    @comment = current_user.comments.build(production_id: @production.id,content: params[:comment][:content])
    @comment.save
    create_notification(@comment, @production.user)

    respond_to do |format|
      format.js
      format.html
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @production = Production.find(@comment.production_id)
    @comment.destroy
    @comments = @production.comments.order(created_at: "DESC")
   respond_to do |format|
      format.js
      format.html
    end
  end
end
