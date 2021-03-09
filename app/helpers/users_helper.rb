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


    def prospect_pay(user)
        total = 0
        basket_data(user).each do |datum|
            total += Product.find(datum.product_id).price
        end
        total
    end
end
