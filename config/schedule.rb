every 1.day, :at => '11:59 pm' do
  runner "Basket.send_basket_count"
end

every 1.day, :at => '11:59 am' do
  runner "Basket.send_basket_count"
end
