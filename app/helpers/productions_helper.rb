module ProductionsHelper
    
    def in_basket(production)
        Basket.find_by(user_id: current_user.id, production_id: production.id)
    end
    
    def categories
        ["スポーツ","ファッション","デジタル","生活", "食品"]
    end
    
    def choice(search_factor)
        production = Production.all.pluck(search_factor)
        production.uniq
    end
    
    def select_store
        stores = {}
        Store.all.each do |store|
            stores.store(store.name,store.id)
        end
        stores
    end
        
end