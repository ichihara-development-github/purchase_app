module Postback

  def update_stocks(num)
    return false unless @product
    @product.update(stock: num)
  end

  def
end
