class SessionController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "ログインしました"
      redirect_to productions_path
    else
      flash[:warning] = "メールアドレスとパスワードが一致しません"
      render "new"
    end
      
  end
  
  def guest_login
    user = User.first
    session[:user_id] = user.id
    flash[:success] = "管理者としてログインしました"
    redirect_to productions_path
    
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end
