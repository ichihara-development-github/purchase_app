require './lib/line_templates'
require './lib/postback'

class LinebotController < ApplicationController

  include LineTemplates
  include Postback

  def check_linked_user?
    @line_user = User.find_by(line_id: @line_id)
    unless @line_user
      link_line(@line_id)
      client.reply_message(@events[0]['replyToken'],link_line_template)
      return false
    end
    true
  end

  def line_bot_information
  end

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
    @link_token = params[:linkToken]
  end

  def line_login
    user = User.find_by(email: params[:line_session][:email])
    if user && user.authenticate(params[:line_session][:password])
      @nonce = SecureRandom.urlsafe_base64
      while Linenonce.find_by(nonce: @nonce).present?
        @nonce = SecureRandom.urlsafe_base64
      end
      ActiveRecord::Base.transaction do
        Linenonce.create(user_id: user.id, nonce: @nonce)
        url = "https://access.line.me/dialog/bot/accountLink?linkToken=#{params[:line_session][:link_token]}&nonce=#{@nonce}"
        redirect_to url
      end
    else
      flash[:warning] = "メールアドレスとパスワードが一致しません"
      @link_token = params[:line_session][:link_token]
      render "link_line_form"
    end
  end

  def callback
    body = request.body.read
    @events = client.parse_events_from(body)
    @events.each do |event|
      @line_id = event["source"]["userId"]
      case event
      when Line::Bot::Event::Message
        return false unless check_linked_user?
        case event.type
        when  Line::Bot::Event::MessageType::Location
          message = search_store(event["message"]["latitude"], event["message"]["longitude"])
          client.push_message(@line_id, message)
        when Line::Bot::Event::MessageType::Image
          client.reply_message(event['replyToken'], sticker_list("thanks"))
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when "店舗検索"
            client.reply_message(event['replyToken'], send_location_template)
          when "メニュー"
            client.reply_message(event['replyToken'], menu_template)
          when "解除"
            client.reply_message(event['replyToken'], unlink_template)
          else
            client.reply_message(event['replyToken'], default_message)
          end
        end
      when Line::Bot::Event::Postback
        return false unless check_linked_user?
        if event["postback"]["data"].include?("display_products_stocks")
          client.reply_message(event['replyToken'], stocks_template)
        elsif event["postback"]["data"].include?("select_stock")
          id = event["postback"]["data"].sub("action=stocks&id=","")
          client.push_message(@line_id, count_template(id))
        elsif event["postback"]["data"].include?("update_stocks")
          Product.find(event["title"]).update(count: event["postback"]["title"].sub("update_stocks&count=",""))
          client.reply_message(event['replyToken'], sticker_list("thanks"))
        elsif event["postback"]["data"].include?("check_total_proceeds")
          message = Postback.check_total_proceeds(@line_user)
          client.push_message(@line_id, message)
        elsif event["postback"]["data"].include?("check_baskets")
          client.push_message(@line_id, baskets_template)
        elsif event["postback"]["data"].include?("purchase")
          client.push_message(@line_id,Postback.purchase(event["postback"]["data"].sub("action=purchase&id=","")))
        elsif event["postback"]["data"].include?("unlink")
          User.find_by(line_id: @line_id).update(line_id: nil)
          client.push_message(@line_id, {"type":"text","text":"LINE連携が解除されました！"})
        end
      when Line::Bot::Event::AccountLink
        nonce = Linenonce.find_by(nonce: event["link"]["nonce"])
        if nonce.user.update(line_id: event["source"]["userId"])
          client.push_message(nonce.user.line_id, hello_message_template(nonce.user))
          client.push_message(nonce.user.line_id, sticker_list("thanks"))
          nonce.destroy
        else
          client.push_message(event["source"]["userId"], sticker_list("sorry"))
        end
      end
         head :ok
    end
  end


end
