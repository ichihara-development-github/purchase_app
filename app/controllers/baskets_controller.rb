class BasketsController < ApplicationController

    before_action :login_user?
    before_action :set_valiable, only: [:create, :destroy]

    def set_valiable
         @product = Product.find(params[:product_id])
         @class_name = ".product-basket-#{@product.id}"
    end



    def index
        @products = current_user.considering_products
    end

    def create
        user = @product.store.user
        current_user.baskets.create(product_id: @product.id)
        create_notification(user, @product, "","basket")
        respond_to do |format|
             format.html
             format.js
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
        @product = Product.find(params[:format])
        Basket.create(user_id: current_user.id, product_id: @product.id)
        flash[:success] = "カートに追加しました"
        redirect_to :back
    end

    def delete
        @basket = Basket.find_by(user_id: current_user.id, product_id: params[:format])
        @basket.destroy
        flash[:success] = "カートにから削除しました"
        redirect_to :back
    end

end
