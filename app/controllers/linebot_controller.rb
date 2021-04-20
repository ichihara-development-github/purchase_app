require './lib/line_templates'

class LinebotController < ApplicationController

  include LineTemplates
  include Postback

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      line_id = event["source"]["userId"]
      @line_user = User.find_by(line_id: line_id)
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Image
          client.reply_message(event['replyToken'], sticker_list("thanks"))
        when Line::Bot::Event::MessageType::Text
          case event.message['text'].class
          when Numeric
            Postback.update_stocks(event.message['text'])
          end
          case event.message['text']
          when "簡単検索"
            client.reply_message(event['replyToken'], stocks_template)
          when "メニュー"
            client.reply_message(event['replyToken'], menu_template)
          else
            client.reply_message(event['replyToken'], default_message)
          end
        end
      when Line::Bot::Event::Postback
        client.push_message(line_id, {"type": "text", "text":"#{event["postback"]["data"]}")
        case event["postback"]["data"]
        when "action=display_products_stocks"
          client.reply_message(event['replyToken'], stocks_template)
        when "action=update_stocks*"
          client.push_message(line_id, {"type": "text", "text":"変更後の個数を入力して下さい"})
          @product = Product.find(event["postback"]["data"].sub(/action=update_stocks&id=/,""))
        when "action=fuga"
          client.reply_message(event['replyToken'], sticker_list("thanks"))
          message = {"type": "text", "text": event["postback"]["data"]}
          client.push_message(line_id, message)
        end
      end
    end
    head :ok
end
end
