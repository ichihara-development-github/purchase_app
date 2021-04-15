require './lib/line_templates'

class LinebotController < ApplicationController

  include LineTemplates

  def create_message(hoge)
    "hoge" + hoge
  end

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    puts "--------------------------#{menu_template}------------------------"

    events.each do |event|
      line_id = event["source"]["userId"]
      @line_user = User.find_by(line_id: line_id)
      case event
      when Line::Bot::Event::Postback
        client.reply_message(event['replyToken'], sticker_list("thanks"))
        client.push_message(line_id, create_message(["postback"]["data"]))
      end

      case event.type
      when Line::Bot::Event::MessageType::Text
        client.reply_message(event['replyToken'], menu_template)
      when Line::Bot::Event::MessageType::Image
        message = {
           type: 'text',
           text: "thanks photo"
         }
        client.reply_message(event['replyToken'], message)
        client.reply_message(event['replyToken'], sticker_list("thanks"))
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
