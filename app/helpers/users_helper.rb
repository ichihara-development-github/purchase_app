module UsersHelper
    include ApplicationHelper

    def purchase_count
        current_user.purchase_products.count
    end

    def purchase_sum
         current_user.purchase_products.sum(:price)
    end

    def considered_count
         current_user.considered_products.count
    end


    def purchase_data(user)
        purchase = []
        user.store.products.each do |product|
            data = Purchase.where(product_id: product.id)
            data.each do |datum|
                purchase << datum
            end
        end
        purchase
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
        purchase_data(user).each do |datum|
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
