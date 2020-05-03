class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
    flash[:success] = 'ログインしました'
  end

  def login_user?
    unless current_user
      flash[:warning] = 'Loginが必要です'
      redirect_to new_session_path
    end
  end

  def seller_user?
    unless current_user.seller?
      flash[:danger] = 'オーナー権限がありません'
      redirect_to new_session_path
    end
  end

  def admin_user?
    unless current_user
      flash[:danger] = '管理者権限がありません'
      redirect_to new_session_path
    end
  end

  def has_authority?(user)
    unless (current_user == user) || current_us
      er.admin
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
end
