require './lib/hubeny_distance'


class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  include HubenyDistance

  before_action :validate_signature, except: [:new, :create]

  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_SECRET"]
      config.channel_token = ENV["LINE_TOKEN"]
    }
  end

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
    flash[:success] = 'ログインしました'
  end

  def login_user?
    unless current_user
      redirect_to new_session_path
      flash[:warning] = 'Loginが必要です'
    end
  end

  def seller_user?
    unless (current_user&.admin) or (current_user&.seller)
      flash[:danger] = 'オーナー権限がありません'
      redirect_to root_path
    end
  end

  def has_store?
    unless current_user && current_user.store
      flash[:warning] = "店舗を所持していません"
      redirect_to new_store_path
    end
  end

  def admin_user?
    unless current_user&.admin
      flash[:danger] = '管理者権限がありません'
      redirect_to root_path
    end
  end

  def has_authority?(user)
    unless current_user && ((current_user == user) || current_user.admin)
      redirect_to root_path
      flash[:danger] = '権限がありません'
    end
  end

  def create_notification(user, product, comment, action)
    unless current_user == user
      notification = current_user.active_notifications.new(
        passive_user_id: user.id,
        action: action.to_s
      )
      notification.product_id = product.id if product.present?
      notification.comment_id = comment.id if comment.present?
      notification.save
    end
  end

protected

def check_captcha(object)
  # redirect_to "/#{object}/new" unless verify_recaptcha
end

end
