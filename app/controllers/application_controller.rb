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
    return unless (current_user == user) || current_user.admin

    redirect_to root_path
    flash[:danger] = '権限がありません'
  end
end
