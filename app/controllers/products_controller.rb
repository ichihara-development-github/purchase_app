class ProductsController < ApplicationController
    before_action :login_user?, only: [:show]
    before_action :has_store?, only: [:new, :edit_products]
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action -> { has_authority?(@product.store.user) }, only: [:edit, :update, :destroy]

  def set_product
    @product = Product.find(params[:id])
  end

  def has_store?
   if current_user.seller && !current_user.store
    flash[:warning] = "店舗を所持していません"
    redirect_to new_store_path
   end
  end

  def new
   @product = Product.new
  end

  def create
     @store = current_user.store
     @product = @store.products.build(product_params)

    if @product.save
      users = current_user.followers
      debugger
      users.each do |user|
        create_notification(user, @product, "", "create")
      end
      redirect_to products_path
      flash[:success] = "商品の作成が完了しました"
    else
      flash[:error_messages] = @product.errors.full_messages
      render "new"
    end
  end


  def index
    @products = Product.paginate(page: params[:page], per_page: 8)
    popular
  end

  def line_up
    if params[:line_up] == "価格が安い"
      @products = Product.order(id: "ASC").paginate(page: params[:page], per_page: 8)
    elsif params[:line_up] == "新着順"
      @products = Product.order(created_at: "ASC").paginate(page: params[:page], per_page: 8)
    elsif params[:line_up] == "購入数"
      @products = popular.paginate(page: params[:page], per_page: 8)
    end
    popular
    render "index"

  end


  def popular
    @popular = Product.order(Arel.sql('Purchaced.group(:product_id).count(:product_id).sort_by{ | _k, v | v }.reverse)')
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
    flash[:error_messages] = @product.errors.full_messages unless  @product.update(product_params)

    flash[:success] = "商品を編集しました"
    redirect_to product_path(@product)
  end

  def destroy
    @product.destroy
    flash[:success] = "削除しました"
    redirect_to edit_products_path
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
        popular
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
          popular
          render "index"
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
