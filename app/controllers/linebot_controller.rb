require './lib/line_templates'
require './lib/postback'


class LinebotController < ApplicationController

  include LineTemplates
  include Postback

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      line_id = event["source"]["userId"]
      # @line_user = User.find_by(line_id: line_id)
      @line_user = User.first
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Image
          client.reply_message(event['replyToken'], sticker_list("thanks"))
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when (1..1000).to_s
              client.reply_message(event['replyToken'], sticker_list("thanks"))
            message = Postback.update_stocks(event.message['text']) ? "更新が完了しました" : default_message
            client.push_message(line_id, message)
          when "簡単検索"
            client.reply_message(event['replyToken'], stocks_template)
          when "メニュー"
            client.reply_message(event['replyToken'], menu_template)
          else
            client.reply_message(event['replyToken'], default_message)
          end
        end
        when Line::Bot::Event::Postback
          if event["postback"]["data"].include?("display_products_stocks")
            client.reply_message(event['replyToken'], stocks_template)
          elsif event["postback"]["data"].include?("update_stocks")
            $product = Product.find(1)
            client.push_message(line_id, {"type": "text", "text":"変更後の個数を入力して下さい"})
          elsif event["postback"]["data"].include?("fuga")
            client.reply_message(event['replyToken'], sticker_list("thanks"))
            message = {"type": "text", "text": event["postback"]["data"]}
            client.push_message(line_id, message)
          elsif event["postback"]["data"].include?("check_total_proceeds")
            message = Postback.check_total_proceeds
            client.push_message(line_id, message)
          elsif event["postback"]["data"].include?("check_baskets")
            client.push_message(line_id, baskets_template)
          elsif event["postback"]["data"].include?("purchase")
            client.push_message(line_id,Postback.purchase(event["postback"]["data"].sub("action=purchase&id=","")))
          end
        end
    end
    head :ok
end
end
