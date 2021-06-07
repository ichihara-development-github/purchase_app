class BasketsController < ApplicationController
    protect_from_forgery :except => [:update]

    before_action :login_user?
    before_action :set_valiable, only: [:create, :destroy]

    def check_stocks

    end

    def set_valiable
         @product = Product.find(params[:product_id])
         @count = params[:count] ||= 1
         @class_name = ".product-basket-#{@product.id}"
    end

    def index
        @baskets = current_user.baskets || []
        @purchases = current_user.purchases || []
        @products = current_user.considering_products || []
    end

    def create
        user = @product.store.user
        @basket = current_user.baskets.build(product_id: @product.id, count: @count) and @basket.save
        create_notification(user, @product, "","basket")
        respond_to do |format|
             format.html
             format.js
        end
    end

    def update
      if Basket.find(params[:id]).update(count: params[:basket][:count])
         respond_to do |format|
              format.html
              format.js
         end
      end
    end

    def destroy
        @basket = current_user.baskets.find_by(product_id: @product.id)
        @basket.destroy
         respond_to do |format|
             format.html
             format.js
         end
    end

    def add
        Basket.create(basket_params)
        flash[:success] = "カートに追加しました"
        redirect_back(fallback_location: baskets_path)
    end

    def delete
        @basket = Basket.find_by(user_id: current_user.id, product_id: params[:format])
        @basket.destroy
        flash[:success] = "カートにから削除しました"
        redirect_back(fallback_location: baskets_path)
    end

    private

    def basket_params
      params.require(:basket).permit(:user_id, :product_id, :count)
    end

end
