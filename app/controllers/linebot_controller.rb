class LinebotController < ApplicationController

  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message["text"].include?("1")
            message = {
              "↓↓メールアドレスとパスワードを入力↓↓\n
            　  1. 登録する\n"
            }
            client.reply_message(event['replyToken'], message)
          end
          user_id = event["source"]["userId"]
          if check_line_user(user_id)
            message = {
              "↓↓番号を選択↓↓\n
            　  1. 登録する\n"
            }
            client.reply_message(event['replyToken'], message)
          else
            message = {
              "type": "text",
              "text": "こんにちは！\n
                   purchase_appへようこそ！\n
                   ↓↓番号を選択↓↓\n
                    1. 開成駅→会社（シャトルバス）\n
                    2. 会社→開成駅（シャトルバス）\n
                    3. 電車の運行状況\n
                    4. 会社周辺の天気\n
                    5. 東京の天気\n\n
                    ※半角数字でお願いします。"

              end
            }
            client.reply_message(event['replyToken'], message)
            client.reply_message(event['replyToken'], sticker_list("thanks"))
          end
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
