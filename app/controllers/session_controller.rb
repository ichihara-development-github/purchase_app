class SessionController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login user
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

  def guest_user_login
    unless User.any?
      user = User.create(name: "user1", email:"user1@user.com", password: "password", admin: true, seller: true)
    else
      user = User.create(name: "user#{@user_id + 1}", email:"user#{@user_id + 1}@user.com", password: "password")
      session[:guest_id] = user.id
    end
    login user
    redirect_to productions_path
  end



  def destroy
    session[:user_id] = nil
    if session[:guest_id]
      User.find(session[:guest_id]).destroy
      session[:guest_id] = nil
    end
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
end
