require './lib/line_templates'

class LinebotController < ApplicationController

  def menu_template
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
                        "type": "postback",
                        "label": "商品を検索",
                        "data": "action=buy&itemid=222"
                    },
                    {
                        "type": "postback",
                        "label": "Add to cart",
                        "data": "action=add&itemid=222"
                    },
                    {
                        "type": "uri",
                        "label": "サイトへ >>",
                        "uri": "https://ichihara-purchase-app.com/session/new"
                    },
                ]
              },
              "#{ower_menu_template}"

          ],
          "imageAspectRatio": "rectangle",
          "imageSize": "cover"
      }
    }
  end


  include LineTemplates

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    p "--------------------------#{ menu_template}------------------------"

    events.each do |event|
    # when Line::Bot::Event::Message
      case event
      when Line::Bot::Event::Message
        @line_user = User.find_by(line_id: event["source"]["userId"])
        case event.type
        when "message"
          client.reply_message(event['replyToken'], menu_template)
        end
      when Line::Bot::Event::MessageType::Image
        message = {
           type: 'text',
           text: "thanks photo"
         }
        client.reply_message(event['replyToken'], message)
      when Line::Bot::Event
          case event.type
          when "postback"
            client.reply_message(event['replyToken'], sticker_list("thanks"))
            client.reply_message(event['replyToken'], "#{events[1].data}")
          end
      end
    end
  end
        # case event.type
        # when Line::Bot::Event::MessageType::Text
        #     message = menu_template
        #     client.reply_message(event['replyToken'], message)
        # when Line::Bot::Event::MessageType::Image
        #     client.reply_message(event['replyToken'], sticker_list("thanks"))
        #     # user_id = event["source"]["userId"]
        #     # client.reply_message(event['replyToken'], sticker_list("thanks"))
        # end
          # push(user_id)
          # @profile = get_line_UserProfile(user_id)
          # if check_line_user(user_id)
          #   send_menue
          # else
          #   message = send_greeting
          #   client.reply_message(event['replyToken'], message)
          # end


# response = client.get_profile(user_id)
# case response
# when Net::HTTPSuccess then
#   contact = JSON.parse(response.body)
#   user_name = contact['displayName']
#   p contact['pictureUrl']
#   p contact['statusMessage']
# else
#   p "#{response.code} #{response.body}"
# end

end
