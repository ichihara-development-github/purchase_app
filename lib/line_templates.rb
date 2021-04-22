module LineTemplates

  IMAGE_PATH = "https://purchase-app-backet.s3.amazonaws.com"

  def default_message
    $product = nil
    {
      "type": "text",
      "text": "こんにちは#{@line_user.name}さん \n 以下のワードを入力して簡単機能を利用してみてください(・ω・)/ \n
      \n【簡単検索】:店舗オーナー専用メニューを開きます
      \n【店舗検索】:店舗オーナー専用メニューを開きます
      \n【メニュー】:店舗オーナー専用メニューを開きます"
    }
  end

  def menu_template
    templates = [
      {
        "thumbnailImageUrl": "https://purchase-app-backet.s3.amazonaws.com/uploads/store.jpg",
        "imageBackgroundColor": "#FFFFFF",
        "title": "メニュー",
        "text": "LINEから簡単に実行できるメニューです",
        "defaultAction": {
            "type": "uri",
            "label": "オーナー登録画面へ",
            "uri": "https://ichihara-purchase-app.com/registration"
        },
        "actions": [
            {
                "type": "postback",
                "label": "商品検索",
                "data": "hoge"
            },
            {
              "type": "postback",
              "label": "カート確認",
              "data": "action=check_baskets"
            },
            {
                "type": "postback",
                "label": "今すぐ購入",
                "data": "fuga"
            },
            {
                "type": "uri",
                "label": "オーナー登録画面へ",
                "uri": "https://ichihara-purchase-app.com/registration"
            }
        ]
      }
    ]
    # templates.push(ower_menu_template) if !!(@line_user and @line_user.store)

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
        "text": "LINEから行える管理メニューです",
        "defaultAction": {
            "type": "uri",
            "label": "サイトへ >>",
            "uri": "https://ichihara-purchase-app.com/session/new"
        },
        "actions": [
            {
              "type": "postback",
              "label": "売り上げ確認",
              "data": "action=check_total_proceeds"
            },
            {
                "type": "postback",
                "label": "在庫変更",
                "data": "action=display_products_stocks"
            },
            {
                "type": "商品価格変更",
                "label": "サイトへ >>",
                 "uri": "https://ichihara-purchase-app.com/session/new"
            },
        ]
      }
  end

  def stocks_template
    list = []
    @line_user.store.products.each do |product|
      list.push({
      "imageUrl": "#{IMAGE_PATH}/#{product.main_image.path}",
      "action": {
        "type": "postback",
        "label": "#{product.count} "+"#{product.name}",
        "data": "action=update_stocks&id=#{product.id}"
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

   def baskets_template
     baskets = []

     User.first.baskets.each do |basket|
       baskets.push({
         "thumbnailImageUrl": "#{IMAGE_PATH}/#{basket.product.main_image.path}",
         "imageBackgroundColor": "#000000",
         "title": "#{basket.product.name}",
         "text": "#{basket.product.description}",
         "actions": [
             {
                 "type": "postback",
                 "label": "購入する",
                 "data": "action=purchase&id=#{basket.product.id}"
             },
         ]
       }
     )
     end
     {
     "type": "template",
     "altText": "this is a carousel template",
     "template": {
         "type": "carousel",
         "columns": baskets,
         "imageAspectRatio": "rectangle",
         "imageSize": "cover"
     }
   }
   end

  def search_result_templat
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
