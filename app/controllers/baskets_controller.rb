class BasketsController < ApplicationController

    before_action :login_user?
    before_action :set_valiable, only: [:create, :destroy]

    def set_valiable
         @production = Production.find(params[:production_id])
         @class_name = ".production-basket-#{@production.id}"
    end

    def create_notification(production, user)

        notification = current_user.active_notifications.new(
          production_id: production.id,
          passive_user_id: user.id,
          action: "カート"
        )
          notification.save
    end


    def index
        @productions = current_user.considering_productions
    end

    def create
        current_user.baskets.create(production_id: @production.id)
        create_notification(@production, @production.store.user)
        respond_to do |format|
             format.html
             format.js
        end
    end

    def destroy
        @basket = current_user.baskets.find_by(production_id: @production.id)
        @basket.destroy
         respond_to do |format|
             format.html
             format.js
         end
    end

    def add
        @production = Production.find(params[:format])
        Basket.create(user_id: current_user.id, production_id: @production.id)
        flash[:success] = "カートに追加しました"
        redirect_to :back
    end

    def delete
        @basket = Basket.find_by(user_id: current_user.id, production_id: params[:format])
        @basket.destroy
        flash[:success] = "カートにから削除しました"
        redirect_to :back
    end

end
