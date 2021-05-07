module Postback extend self

  def update_stocks(num)
    return false unless $product
    $product.update(stock: num)
  end

  def check_total_proceeds(user)
    counts = total = 0
    user.store.products.each do |product|
      counts += product.purchases.sum(:count)
      total += (product.price * counts)
    end
     {
      "type": "text",
      "text": "_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/ \n 現在売り上げ: #{total}\n 売上個数: #{counts}\n 平均単価: #{total/[counts, 1].max} \n /_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/"
     }
  end

  def purchase(id)
    product = Product.find(id)
    {
     "type": "text",
     "text": "#{product.name}の購入が完了しました"
    }
  end

end
