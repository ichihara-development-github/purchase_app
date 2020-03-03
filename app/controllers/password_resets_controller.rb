class PasswordResetsController < ApplicationController

    before_action :get_user, only: [:edit, :update]
    before_action :valid_user, only: [:edit, :update]
    before_action :check_expration, only: [:edit, :update]


    def new
    end

    def create
        @user = User.find_by(email: params[:password_reset][:email])
        if @user
            @user.create_reset_digest
            @user.send_password_reset_mail
            flash[:info] = "#{params[:password_reset][:email]}にメールを送信しました"
            redirect_to root_path
        else
            flash.now[:danger] = "メールアドレスが見つかりませんでした"
            render "new"
        end
    end

    def edit
    end

    def update
        if params[:user][:password].empty?
            flash[:danger] = "passwordが入力されていません"
            render "edit"
        elsif @user.update(user_params)
            login @user
            @user.update(:reset_digest, nil)
            redirect_to @user
        else
            render "edit"
        end
    end

    private

    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
        @user = User.find_by(email: params[:email])
    end

    def valid_user
        unless @user && @user.authenticated?(:reset, params[:id])
            flash[:danger] = "リンクが有効ではありません"
            redirect_to root_path
        end
    end

    def check_expration
        if @user.password_reset_expired?
            flash[:danger] = "パスワードリセットの有効期限が切れています"
            redirect_to new_password_reset_path
        end
    end
end
