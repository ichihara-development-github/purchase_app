class Basket < ApplicationRecord
  require "Line"

  def self.send_basket_count
    num = Basket.where("DATE(created_at) = '#{Date.today}'").count
    notice = "【#{Date.today}】カート追加#{num}"
    Line.send(notice)
  end
  belongs_to :product
  belongs_to :user
end
