module LineTemplates

  IMAGE_PATH = "https://purchase-app-backet.s3.amazonaws.com/"

  def default_message
    {
      "type": "text",
      "text": "以下のワードを入力して簡単機能を利用してみてください(・ω・)/
      /n【簡単検索】: 店舗オーナー専用メニューを開きます
      /n【店舗検索】: 店舗オーナー専用メニューを開きます
      /n【メニュー】: 店舗オーナー専用メニューを開きます"
    }
  end

  def menu_template
    {
      "type": "template",
      "altText": "this is a carousel template",
      "template": {
          "type": "carousel",
          "columns": [
              {
                "thumbnailImageUrl": "https://purchase-app-backet.s3.amazonaws.com/uploads/store.jpg",
                "imageBackgroundColor": "#FFFFFF",
                "title": "メニュー",
                "text": "description",
                "actions": [
                    {
                        "type": "postback",
                        "label": "Buy",
                        "data": "hoge"
                    },
                    {
                        "type": "postback",
                        "label": "Add to cart",
                        "data": "hoge"
                    },
                    {
                        "type": "uri",
                        "label": "サイトへ",
                        "uri": "https://ichihara-purchase-app.com/session/new"
                    }
              ]
         }
    ],
    "imageAspectRatio": "rectangle",
    "imageSize": "cover"
}
}
  end

  def ower_menu_template
      {
        "thumbnailImageUrl": "https://purchase-app-backet.s3.amazonaws.com/uploads/store.jpg",
        "imageBackgroundColor": "#FFFFFF",
        "title": "管理者メニュー",
        "text": "description",
        "defaultAction": {
            "type": "uri",
            "label": "サイトへ >>",
            "uri": "https://ichihara-purchase-app.com/session/new"
        },
        "actions": [
            {
                "type": "postback",
                "label": "売上確認",
                "data": "action=buy&itemid=111"
            },
            {
                "type": "postback",
                "label": "在庫変更",
                "data": "action=user_id=22"
            },
            {
                "type": "uri",
                "label": "サイトへ >>",
                 "uri": "https://ichihara-purchase-app.com/session/new"
            },
        ]
      }
  end

  def stocks_template
    product = Product.first

    {
  "type": "template",
  "altText": "this is a image carousel template",
  "template": {
      "type": "image_carousel",
      "columns": [
          {
            "imageUrl": "#{IMAGE_PATH}/#{product.main_image.path}",
            "action": {
              "type": "postback",
              "label": "#{product.name}",
              "data": "name=hoge"
            }
          }
      ]
  }
}
  end

  def search_result_template
    {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
        "type": "carousel",
        "columns": [
            {
              "thumbnailImageUrl": "https://purchase-app-backet.s3.amazonaws.com/uploads/store.jpg",
              "imageBackgroundColor": "#000000",
              "title": "メニュー",
              "text": "description",
              "actions": [
                  {
                      "type": "uri",
                      "label": "サイトへ >>",
                      "uri": "https://ichihara-purchase-app.com/products/5"
                  },
              ]
            },
        ],
        "imageAspectRatio": "rectangle",
        "imageSize": "cover"
    }
  }
  end

end
