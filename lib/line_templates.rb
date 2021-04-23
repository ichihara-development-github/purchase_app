module LineTemplates

  IMAGE_PATH = "https://purchase-app-backet.s3.amazonaws.com"
  def search_store(longitude, latitude)
    uri = URI("http://express.heartrails.com/api/json")
    uri.query = URI.encode_www_form({
    method: "getStations",
      x: longitude,
      y: latitude
    })
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)["response"]["station"]
  end

  def default_message
    $product = nil
    {
      "type": "text",
      "text": "こんにちは#{@line_user.name}さん \n 以下のワードを入力して簡単機能を利用してみてください(・ω・)/ \n
      \n【簡単検索】:
      \n【店舗検索】:位置情報から送料無料の店舗を検索
      \n【メニュー】:簡単メニューを開きます"
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
            # {
            #     "type": "postback",
            #     "label": "",
            #     "data": "hoge"
            # },
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
        ]
      }
    ]
    templates.push(ower_menu_template) if !!(@line_user and @line_user.store)

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
                "type": "uri",
                "label": "商品価格変更",
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
         "defaultAction": {
             "type": "uri",
             "label": "カートへ",
             "uri": "https://ichihara-purchase-app.com/baskets"
         },
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

  def send_location_template
  {
    "type": "template",
    "altText": "位置検索中",
    "template": {
        "type": "buttons",
        "title": "店舗を検索してみる",
        "text": "位置情報を送信しますか？",
        "actions": [
            {
              "type": "uri",
              "label": "位置情報を送る",
              "uri": "line://nv/location"
            }
        ]
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
