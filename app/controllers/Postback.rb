module Postback

  def update_stocks(num)
    @product.update(stock: num)
  end
end
