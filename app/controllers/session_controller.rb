class SessionController < ApplicationController
  def new

  end


  def login(user)
    session[:user_id] = user.id
    flash[:success] = 'ログインしました'
    return redirect_to line_login_path(link_token: params[:link_token]) if params[:link_token].present?
    redirect_after_login(root_path)
  end

  def create
    unless current_user
      user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        login user
      else
        flash[:warning] = "メールアドレスとパスワードが一致しません"
        render "new"
      end
    else
      redirect_to products_path
      flash[:warning] = "すでに#{current_user.name}としてログインしています"
    end
  end

  def guest_login
    user = User.first
    login user
  end

  def guest_user_login
    unless User.any?
      user = User.create(name: "user1", email:"user1@user.com", password: "password",admin: true, seller: true)
    else
      user_id = User.last.id
      user = User.create(name: "user#{user_id + 1}", email:"user#{user_id + 1}@user.com",address: "東京",password: "password")
      session[:guest_id] = user.id
    end
    login user
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
