module UsersHelper
    
    
    def purchaced_count(user)
        user.purchaced_productions.count
        
    end
    
    def purchaced_sum(user)
         user.purchaced_productions.sum(:price)
    end
    
    def considered_count(user)
         user.considered_productions.count
    end
    
    
    def purchaced_data(user)
        purchaced = []
        user.store.productions.each do |production| 
            data = Purchaced.where(production_id: production.id)
            data.each do |datum|
                purchaced << datum
            end
        end
        purchaced
    end
    
     def basket_data(user)
        basket = []
        user.store.productions.each do |production| 
            data = Basket.where(production_id: production.id)
            data.each do |datum|
                basket << datum
            end
        end
        basket
    end
    
    def pay_off(user)
        total = 0
        purchaced_data(user).each do |datum|
            total += Production.find(datum.production_id).price
        end
        total
    end
    
    def prospect_pay(user)
        total = 0
        basket_data(user).each do |datum|
            total += Production.find(datum.production_id).price
        end
        total
    end
end
