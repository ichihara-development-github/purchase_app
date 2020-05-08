module UsersHelper
    include ApplicationHelper

    def purchaced_count
        current_user.purchaced_products.count
    end

    def purchaced_sum
         current_user.purchaced_products.sum(:price)
    end

    def considered_count
         current_user.considered_products.count
    end


    def purchaced_data(user)
        purchaced = []
        user.store.products.each do |product|
            data = Purchaced.where(product_id: product.id)
            data.each do |datum|
                purchaced << datum
            end
        end
        purchaced
    end

    def basket_data(user)
        basket = []
        user.store.products.each do |product|
            data = Basket.where(product_id: product.id)
            data.each do |datum|
                basket << datum
            end
        end
        basket
    end

    def pay_off(user)
        total = 0
        purchaced_data(user).each do |datum|
            total += Product.find(datum.product_id).price
        end
        total
    end

    def prospect_pay(user)
        total = 0
        basket_data(user).each do |datum|
            total += Product.find(datum.product_id).price
        end
        total
    end
end
