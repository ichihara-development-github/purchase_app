class Comment < ApplicationRecord


    IMAGE_PATH = "https://purchase-app-backet.s3.amazonaws.com"


  def self.hoge
    products = Product.first
    list = []
    User.first.store.products.each do |product|
      list.append({
      "imageUrl": "#{IMAGE_PATH}/#{ product.main_image.path}",
      "action": {
        "type": "postback",
        "label": "#{product.name}\n現在在庫: #{product.count}",
        "data": "update_stocks&id = #{product.id}"
       }
      })
    end
    hoge = {
      "type": "template",
      "altText": "this is a image carousel template",
      "template": {
          "type": "image_carousel",
          "columns": list
          ]
      }
     }
  hoge
  end
  belongs_to :user
  belongs_to :product

  validates :content, presence: true, length: { maximum: 100}
end
