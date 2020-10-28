require 'will_paginate/array'

class ProductsController < ApplicationController
    before_action :has_store?, only: [:new, :edit_products]
    before_action :login_user?, only: [:show]
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action -> { has_authority?(@product.store.user) }, only: [:edit, :update, :destroy]

  def set_product
    @product = Product.find(params[:id])
  end

  def new
   @product = Product.new
  end

  def create
     @store = current_user.store
     @product = @store.products.build(product_params)
    if @product.save
      users = current_user.followers
      users.map{|user| create_notification(user, @product, "", "create") }
      flash[:success] = "商品の作成が完了しました"
      redirect_to @product
      Product.input_request(@product.name)
    else
      flash[:error_messages] = @product.errors.full_messages
      render "new"
    end
  end


  def index
    @products = Product.paginate(page: params[:page], per_page: 8)
    @popular = Product.popular
  end

  def show
    @comment = Comment.new
    @comments = @product.comments.order(created_at: "DESC")
    @distance = distance(current_user.latitude, current_user.longitude, @product.store.latitude, @product.store.longitude)
  end

  def edit_products
      @products = current_user.store.products
  end

  def edit
  end

  def update
    old_name = @product.name
    if @product.update(product_params)
      name = @product.name
      flash[:success] = "商品を編集しました"
      redirect_to product_path(@product)
      Product.update_request(old_name, name)
    else
      flash[:error_messages] = @product.errors.full_messages
      render "edit"
    end
  end

  def destroy
    name = @product.name
    if @product.destroy
      flash[:success] = "削除しました"
      redirect_to edit_products_path
      Product.delete_request(name)
    else
      flash[:error_messages] = @product.errors.full_messages
      render "edit_product"
    end
  end

  #----------------------line up------------------------------

  def line_up
    if params[:line_up] == "価格が安い"
      @products = Product.order(price: "ASC").paginate(page: params[:page], per_page: 8)
    elsif params[:line_up] == "価格が高い"
      @products = Product.order(price: "DESC").paginate(page: params[:page], per_page: 8)
    elsif params[:line_up] == "新着順"
      @products = Product.order(created_at: "DESC").paginate(page: params[:page], per_page: 8)
    elsif params[:line_up] == "購入数"
      @products = Product.popular.paginate(page: params[:page], per_page: 8)
    elsif params[:line_up] == "レビュー件数"
      @products = Product.has_many_reviews.paginate(page: params[:page], per_page: 8)
    elsif params[:line_up] == "レビュー平均"
      @products = Product.products_review_avarage.paginate(page: params[:page], per_page: 8)
    end
    @popular = Product.popular
    render "index"
  end

 #-------------------------search-------------------------------

  def search
    if search_params.values.all?("")
      redirect_to products_path
    else
      @products = Product.search(search_params).paginate(page: params[:page], per_page: 10)
      if @products.blank?
        flash[:warning] = "マッチする商品が見つかりませんでした"
        redirect_to products_path
      else
        @popular = Product.popular
        render "index"
      end
    end
  end

    def free_search
        @products = Product.free_search(params[:free_word]).paginate(page: params[:page], per_page: 10)
        if @products.blank?
          flash[:warning] = "マッチする商品が見つかりませんでした"
          redirect_to products_path
        else
          @popular = Product.popular
          render "index"
        end
    end

    #------------------------compare---------------------

    def compare
      name = params[:name]
      @price = Product.send_get_request(name)
      respond_to do |format|
        format.html
        format.js
      end
    end


  private
  def product_params
    params.require(:product).permit(:name,:description, :price, :category, :main_image, :sub_image1, :sub_image2 )
  end

  def search_params
    params.permit(:min, :max, :store_id, :category)
  end

end
