module ProductsHelper

  def has_product?(product)
      current_user.store.products.include?(product) if current_user.store
  end

    def in_basket(product)
      Basket.find_by(user_id: current_user.id, product_id: product.id)
    end

    def categories
      category = %w(スポーツ ファッション デジタル 生活  食品)
    end

    def line_up_list
      line_up = %w(価格が安い 価格が高い 購入数新 着順)
    end

    def choice(search_factor)
      product = Product.all.pluck(search_factor)
      product.uniq
    end

    def select_store
        stores = {}
        Store.all.map{|store|stores.store(store.name,store.id) }
        stores
    end

end
