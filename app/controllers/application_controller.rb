class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def current_user
        if session[:user_id]
          @current_user = User.find(session[:user_id])
        end
  end
  
  def login_user?
    unless current_user
      flash[:warning] = "Loginが必要です"
      redirect_to new_session_path 
    end
  end
  
  def seller_user?
     unless current_user
      flash[:danger] = "オーナー権限がありません"
      redirect_to new_session_path 
    end
  end
  
  def admin_user?
     unless current_user
      flash[:danger] = "管理者権限がありません"
      redirect_to new_session_path 
    end
  end
  
  
  def has_authority?(user)
     unless (current_user == user ) or current_user.admin 
      redirect_to root_path
      flash[:danger] = "権限がありません"
    end
    
  end
  

  
end
 