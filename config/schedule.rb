every 1.day, :at => '0:00 am' do
  runner "Basket.send_basket_count"
end

every 1.day, :at => '0:00 pm' do
  runner "Basket.send_basket_count"
end
