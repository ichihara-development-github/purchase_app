require './lib/line_templates.rb'

class LinebotController < ApplicationController

  include LineTemplates

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    event = events[0]

    case events.type
      @line_user = User.find_by(line_id: events[0]["source"]["userId"])
    when "postback"
      client.reply_message(event['replyToken'], sticker_list("thanks"))
      client.reply_message(event['replyToken'], "#{events[1].data}")
    # when Line::Bot::Event::Message
    when "message"
      client.reply_message(event['replyToken'], menu_template)
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
      end
    end

private
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

def get_line_UserProfile(user_id)
  response  = client.get_profile(user_id)
  case response
  when Net::HTTPSuccess then
    contact = JSON.parse(response.body)
  else
    p "#{response.code} #{response.body}"
  end
end

def send_greeting

end

def send_menu
end


end
