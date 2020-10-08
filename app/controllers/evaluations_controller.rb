class EvaluationsController < ApplicationController

  before_action :set_evaluation, only: [:edit, :update, :destroy]
  before_action :user_has_not_reviewed?, only: [:new, :create]
  before_action :user_has_reviewed?, only: [:edit, :update, :destroy]
  before_action :set_product, only: [:new, :index]
  before_action -> { has_authority?(@evaluation.user) }, only: [:edit, :update, :destroy]

  def set_evaluation
    @evaluation = Evaluation.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def user_has_not_reviewed?
    if current_user.reviewed_products.include?(@product)
       redirect_to root_path
       flash[:danger] = "すでにレビューを作成しています"
     end
  end

  def user_has_reviewed?
      unless current_user.evaluations.include?(@evaluation)
        redirect_to root_path
        flash[:danger] = "この商品のレビューを書いていません"
      end
  end

  def index
      @evaluations = @product.evaluations.paginate(page: params[:page], per_page: 10)
  end

  def new
    @evaluation = Evaluation.new
  end

  def create
    @product = Product.find(params[:evaluation][:product_id])
    @evaluation = current_user.evaluations.build(evaluation_params)
    if @evaluation.save
      create_notification(@product.store.user, @product, "", "evaluate")
      redirect_to evaluations_path(id: @product.id)
      flash[:success] = "星#{@evaluation.star}の評価をつけました"
    else
      flash[:error_messages] = @evaluation.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
    flash[:error_messages] = @evaluation.errors.full_messages unless  @evaluation.update(evaluation_params)
    flash[:success] = "評価を編集しました"
    redirect_to evaluations_path(id: @evaluation.product.id)
  end

  def destroy
    redirect_to evaluations_path(id: @evaluation.product.id)
    if @evaluation.destroy
      flash[:success] = "評価を削除しました"
    else
      flash[:success] = "削除できませんでした"
      flash[:error_messages] = @evaluation.errors.full_messages
    end
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:product_id, :star, :comment)
  end

end
