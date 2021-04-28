require './lib/line_templates'
require './lib/postback'


class LinebotController < ApplicationController

  include LineTemplates
  include Postback

  def link_line(userId)
    url = "https://api.line.me/v2/bot/user/#{userId}/linkToken"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)
    headers = {"Authorization" => "Bearer #{ENV["LINE_TOKEN"]}", "Content-Type" => "application/json"}
    req.initialize_http_header(headers)
    res = http.request(req)
    return false unless res.class == Net::HTTPOK
    @link_token = JSON.parse(res.body)["linkToken"]
  end

  def link_line_form
    @link_token = params[:link_token]
    # {
    # "type": "template",
    # "altText": "this is a link line template",
    # "template": {
    #     "type": "buttons",
    #         "text": "アカウントを連携",
    #         "actions": [{
    #             "type": "uri",
    #             "label": "アカウント連携",
    #             "uri": "https://ichihara-purchase-app.com//link_line_form?linkToken=#{link_token}"
    #         }]
    #   }
    # }
    # https://access.line.me/dialog/bot/accountLink?linkToken={link token}&nonce={nonce}

  end

  def line_login
    user = User.find_by(email: params[:line_session][:email])
    if user && user.authenticate(params[:line_session][:password])
      Linenonce.create(user_id: user.id,nonce: "hogehogehogehogehogehoge")
      url = "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:line_session][:link_token]}&nonce=hogehogehogehogehogehoge"
      redirect_to url
    else
      flash[:warning] = "メールアドレスとパスワードが一致しません"
      render "link_line_form"
    end
  end

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      @line_id = event["source"]["userId"]
      # @line_user = User.find_by(@line_id: @line_id)
      @line_user = User.first
      case event
      when Line::Bot::Event::Message
        case event.type
        when  Line::Bot::Event::MessageType::Location
          message = search_store(event["message"]["latitude"], event["message"]["longitude"])
          client.push_message(@line_id, message)
        when Line::Bot::Event::MessageType::Image
          client.reply_message(event['replyToken'], sticker_list("thanks"))
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when (1..1000).to_s
              client.reply_message(event['replyToken'], sticker_list("thanks"))
            message = Postback.update_stocks(event.message['text']) ? "更新が完了しました" : default_message
            client.push_message(@line_id, message)
          when "LINE連携"
            client.reply_message(event['replyToken'], link_line_template(@link_token)) if link_line(@line_id)
          when "店舗検索"
            client.reply_message(event['replyToken'], send_location_template)
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
            client.push_message(@line_id, {"type": "text", "text":"変更後の個数を入力して下さい"})
          elsif event["postback"]["data"].include?("fuga")
            client.reply_message(event['replyToken'], sticker_list("thanks"))
            message = {"type": "text", "text": event["postback"]["data"]}
            client.push_message(@line_id, message)
          elsif event["postback"]["data"].include?("check_total_proceeds")
            message = Postback.check_total_proceeds(@line_user)
            client.push_message(@line_id, message)
          elsif event["postback"]["data"].include?("check_baskets")
            client.push_message(@line_id, baskets_template)
          elsif event["postback"]["data"].include?("purchase")
            client.push_message(@line_id,Postback.purchase(event["postback"]["data"].sub("action=purchase&id=","")))
          end
        end
      when Line::Bot::Event::AccountLink
        nonce = Linenonce.find_by(nonce: event["link"]["nonce"])
        if nonce.user.update(line_id: event["source"]["userId"])
          client.push_message(user.line_id, hello_message_template(line_user))
          client.push_message(user.line_id, sticker_list("thanks")
        else
          client.push_message(user.line_id, sticker_list("sorry")
        end
      end
    end
    head :ok
end
end
