class CommentsController < ApplicationController

  before_action :login_user?, only: [:create]
  before_action :set_comment, only: [:destroy]
  before_action -> {has_authority?(@comment.user) }, only: [:destroy]

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def create
    @product = Product.find(params[:comment][:id])
    @comments = @product.comments.order(created_at: "DESC")
    @comment = current_user.comments.build(product_id: @product.id,content: params[:comment][:content])
    @comment.save
    create_notification(@product.store.user, "",@comment,"comment")

    respond_to do |format|
      format.js
      format.html
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @product = Product.find(@comment.product_id)
    @comment.destroy
    @comments = @product.comments.order(created_at: "DESC")
   respond_to do |format|
      format.js
      format.html
    end
  end
end
