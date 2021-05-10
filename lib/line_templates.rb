require './app/helpers/baskets_helper'

module LineTemplates

  include BasketsHelper

  IMAGE_PATH = "https://purchase-app-backet.s3.amazonaws.com"

  def link_line_template
    {
    "type": "template",
    "altText": "this is a link line template",
    "template": {
        "type": "buttons",
            "text": "こんにちは！\n\n LINEボットではLINEを通して様々な簡単操作やアプリの通知を受け取ることができます。  \n アカウント連携してみて下さい！",
            "actions": [{
                "type": "uri",
                "label": "アカウントを連携する",
                "uri": "https://ichihara-purchase-app.com/link_line_form?linkToken=#{@link_token}"
            }]
      }
    }
  end

  def unlink_template
    {
    "type": "template",
    "altText": "this is a unlink line template",
    "template": {
        "type": "buttons",
            "text": "連携解除",
            "actions": [{
                "type": "postback",
                "label": "アカウント連携を解除する",
                "data": "action=unlink"
            }]
      }
    }
  end

  # def already_line_user_template
  #   {
  #     "type": "text",
  #     "text": "こんにちは#{@line_user.name}さん！ \n 既にLINE連携は完了しているので以下のワードを入力して簡単機能を利用してみてください(・ω・)/ \n
  #     \n【簡単検索】:
  #     \n【店舗検索】:位置情報から送料無料の店舗を検索
  #     \n【メニュー】:簡単メニューを開きます\n\n また連携を解除する場合は【解除】と入力してください！"
  #   }
  # end

  def initial_line_link_template
    {
      "type": "text",
      "text": "こんにちは！\n\n LINEボットではLINEを通して様々な簡単操作やアプリの通知を受け取ることができます。  \n まずは【LINE連携】と打ってLINEアカウントと連携してみて下さい！"
    }
  end

  def search_store(latitude, longitude)
    stores = []

    Store.all.each do |store|

      stores.push({
        "thumbnailImageUrl": "#{IMAGE_PATH}/#{store.top_image.path}",
        "imageBackgroundColor": "#000000",
        "title": "#{store.name}",
        "text": "#{store.description}",
        "actions": [
            {
                "type": "uri",
                "label": "店舗へ",
                "uri": "https://ichihara-purchase-app.com/stores/#{store.id}"
            },
        ]
      }) if distance(latitude, longitude, store.latitude, store.longitude) < 5
    end

    return {"type": "text", "text": "近くの店舗はありませんでした。"}if stores.empty?

    {
    "type": "template",
    "altText": "this is a carousel template",
    "template": {
        "type": "carousel",
        "columns": stores,
        "imageAspectRatio": "rectangle",
        "imageSize": "cover"
      }
    }
  end

  def default_message
    {
      "type": "text",
      "text": " \n 以下のワードを入力して簡単機能を利用してみてください(・ω・)/ \n
      \n【店舗検索】:位置情報から送料無料の店舗を検索
      \n【メニュー】:簡単メニューを開きます
      \n【ヘルプ】:ｋｆｊｊｆｋｄｊｆかｊｆ
      \n\n\n また【解除】と入力するとLINE連携を解除します。"
    }
  end

  def menu_template

    templates = [
      {
        "thumbnailImageUrl": "https://purchase-app-backet.s3.amazonaws.com/uploads/store.jpg",
        "imageBackgroundColor": "#FFFFFF",
        "title": "メニュー",
        "text": "LINEから簡単に実行できるメニューです",
        "actions": [
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
                "label": "サイトへ画面へ",
                "uri": "https://ichihara-purchase-app.com"
            }
        ]
      }
    ]

    templates.push(owner_menu_template) if !!(@line_user and @line_user.store)

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

  def owner_menu_template
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
              "label": "売り上げ確認",
              "data": "action=check_total_proceeds"
          },
          {
              "type": "postback",
              "label": "在庫変更",
              "data": "action=display_products_stocks"
          },
          {
              "type": "postback",
              "label": "価格変更",
              "data": "action=display_products_stock"
          }
      ]
    }

  end

  def stocks_template
    list = []
    @line_user.store.products.each do |product|
      list.push(
        {
             "imageUrl": "#{IMAGE_PATH}/#{product.main_image.path}",
             "action": {
               "type": "postback",
               "label": "#{product.count}",
               "data":"action=stocks&id=#{product.id}"
             }
      }.with_indifferent_access
    )
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

   def count_template(id)
     {
       "type": "template",
       "template": {
           "type": "buttons",
           "title": "#{id}",
           "text": "変更後の個数を選択してください",
           "actions": [
               {
                 "type": "postback",
                 "label": "10個",
                 "data": "update_stocks&count=10"
               },
               {
                 "type": "postback",
                 "label": "50個",
                 "data": "update_stocks&count=50"
               }
           ]
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

def hello_message_template(user)
  user =
  {"type": "text",
   "text": "こんにちは#{user.name}さん!\n"}
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
