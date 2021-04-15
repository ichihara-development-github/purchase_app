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
        case　event.message['text']
        when "簡単検索"
        when "メニュー"
          client.reply_message(event['replyToken'], menu_template)
        else
          client.reply_message(event['replyToken'], default_message)
        end
      when Line::Bot::Event::MessageType::Image
        client.reply_message(event['replyToken'], sticker_list("thanks"))
      end
    end
  end
  "OK"

end
