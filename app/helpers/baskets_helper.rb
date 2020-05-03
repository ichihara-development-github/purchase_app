module BasketsHelper



    def basket_count(user)
        user.considering_products.count
    end
    def basket_sum(user)
        user.considering_products.sum(:price)
    end
end
