require 'line/bot'

class LinebotController < ApplicationController

  def check_line_user(id)
    return false if User.find(line_id: id)
  end

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          user_id = event["source"]["userId"]
          push user_id
          # @profile = get_line_UserProfile(user_id)
          # if check_line_user(user_id)
          #   send_menue
          # else
          #   message = send_greeting
          #   client.reply_message(event['replyToken'], message)
          # end
        end
      end
    end
  end

  def push(id)
    message={
            "type": 'sticker',
            "packageId": " 6359",
            "stickerId": "11069856"
           }
        response = client.push_message(id, message)
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

end
