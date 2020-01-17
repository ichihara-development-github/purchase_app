module BasketsHelper
    

    
    def basket_count(user)
        user.considering_productions.count
    end
    def basket_sum(user)
        user.considering_productions.sum(:price)
    end
end
