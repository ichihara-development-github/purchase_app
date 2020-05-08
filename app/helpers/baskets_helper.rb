require './lib/hubeny_distance'

module BasketsHelper

  include ApplicationHelper
  include HubenyDistance


    def basket_count
        current_user.considering_products.count
    end

    def postage
      products = current_user.considering_products
      stores = []
      fee = 0

      user_lat = current_user.latitude
      user_lng = current_user.longitude

      products.each do |product|
        stores.push product.store
      end
      stores.uniq.each do |store|
        distance = distance(user_lat,user_lng,store.latitude, store.longitude)
        fee += how_much_postage(distance)
      end

      fee
    end

    def basket_sum
      total = current_user.considering_products.sum(:price)
    end

end
