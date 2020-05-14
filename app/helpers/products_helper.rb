module ProductsHelper

  def has_product(product)
    if current_user.store
      current_user.store.products.select(product)
    end
  end

    def in_basket(product)
      Basket.find_by(user_id: current_user.id, product_id: product.id)
    end

    def categories
      ["スポーツ","ファッション","デジタル","生活", "食品"]
    end

    def line_up_list
      ["価格が安い","価格が高い","購入数","新着順"]
    end

    def choice(search_factor)
      product = Product.all.pluck(search_factor)
      product.uniq
    end

    def select_store
        stores = {}
        Store.all.each do |store|
            stores.store(store.name,store.id)
        end
        stores
    end

end
