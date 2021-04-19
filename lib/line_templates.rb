module LineTemplates

  IMAGE_PATH = "https://purchase-app-backet.s3.amazonaws.com"

  def default_message
    {
      "type": "text",
      "text": "以下のワードを入力して簡単機能を利用してみてください(・ω・)/ \n
      \n【簡単検索】:\n店舗オーナー専用メニューを開きます
      \n【店舗検索】:\n店舗オーナー専用メニューを開きます
      \n【メニュー】:\n店舗オーナー専用メニューを開きます"
    }
  end

  def menu_template
    templates = [
      {
        "thumbnailImageUrl": "https://purchase-app-backet.s3.amazonaws.com/uploads/store.jpg",
        "imageBackgroundColor": "#FFFFFF",
        "title": "メニュー",
        "text": "description",
        "actions": [
            {
                "type": "postback",
                "label": "hoge",
                "data": "hoge"
            },
            {
                "type": "postback",
                "label": "fuga",
                "data": "fuga"
            },
            {
                "type": "uri",
                "label": "サイトへ",
                "uri": "https://ichihara-purchase-app.com/session/new"
            }
        ]
      }
    ]
    templates.push ower_menu_template if !!(@line_user and @line_user.store)
    {
          "type": "template",
          "altText": "this is a carousel template",
          "template": {
              "type": "carousel",
              "columns": templates,
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
                "data": "action=display_products_stocks"
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
    list = []
    User.first.store.products.each do |product|
      list.push({
      "imageUrl": "#{IMAGE_PATH}/#{product.main_image.path}",
      "action": {
        "type": "postback",
        "label": "在庫 #{product.count}; #{product.name} ",
        "data": "update_stocks"
       }
      }.with_indifferent_access)
    end
    {
      "type": "template",
      "altText": "this is a image carousel template",
      "template": {
          "type": "image_carousel",
          "columns": list
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

  def sticker_list(type)
    case type
    when "thanks"
      {
              "type": 'sticker',
              "packageId": " 6359",
              "stickerId": "11069856"
             }
    when "congratulation"
      {
              "type": 'sticker',
              "packageId": "1070",
              "stickerId": "17844"
             }
    when "sorry"
      {
              "type": 'sticker',
              "packageId": "6136",
              "stickerId": "10551383"
             }
    end
  end


end
