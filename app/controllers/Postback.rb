module Postback

  def update_stocks(num)
    return false unless $product
    $product.update(stock: num)
  end

  def check_total_proceeds
    counts = total = 0
    @line_user.store.products.each do |product|
      counts += product.purchases.sum(:count)
      total += (product.price * counts)
    end
    messsage = {
      "type": "text",
       "text": "現在売り上げ: #{total}\n
       売上個数: #{counts}\n
       平均単価: #{total/counts}"

     }
  end

end
