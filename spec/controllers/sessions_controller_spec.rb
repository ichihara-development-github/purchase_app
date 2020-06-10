require 'application_controller'
require "./spec/controllers/shared_test"
require 'rails_helper'

RSpec.describe SessionController, type: :controller do

  include Shared_test

  let(:user){User.first}

  it "get new" do
    get :new
    expect(response.status).to eq(200)
  end

  describe "post create" do

    context "user is not logged in" do

      context "user is found" do
        before{post :create, params: {session: {email: user.email, password: "password"}}}

        it "is redirect to loginpage" do
          expect(response).to redirect_to products_path
        end
      end

      context "user is not found" do

        before{post :create, params: {session: {email: user.email, password: "hogehoge"}}}


        it "is rendering session new template" do
          expect(response).to render_template("new")
        end

        it "assign the warning message to flash" do
          expect(flash[:warning]).to eq "メールアドレスとパスワードが一致しません"
        end
      end

    end

    context "user has already logged in" do
      before do
        login(1)
        post :create, params: {session: {email: user.email, password: "password"}}
      end

      it "is redirect to loginpage" do
        expect(response).to redirect_to new_session_path
      end

      it "assign the warning message to flash" do
        expect(flash[:warning]).to eq "すでに#{user.name}としてログインしています"
      end
    end
  end

  describe "guest log in" do
    context "log in as guest admin" do

      before{ post :guest_login}

      it "assign the success message to flash" do
        expect(flash[:success]).to eq "管理者としてログインしました"
      end

      it "is redirect to loginpage" do
        expect(response).to redirect_to products_path
      end
    end

    context "log in as guest user" do

      it "Was new user saved in the database"  do
        expect{
        post :guest_user_login}.to change(User, :count).by(1)
      end

      it "is redirect to loginpage" do
        post :guest_user_login
        expect(response).to redirect_to products_path
      end
    end

  end

  describe "delete destroy" do

    before{delete :destroy,id: 1}

    context "user has logged in as guest account" do
      it "is user_id in session deleted?" do
        expect(session[:guest_id]).to eq nil
      end

      it "is user_id in session deleted?" do
        expect(session[:user_id]).to eq nil
      end
    end

    context "user has logged in as self account" do
      it "is user_id in session deleted?" do
        expect(session[:user_id]).to eq nil
      end
    end

    it "assign the success message to flash" do
      expect(flash[:success]).to eq "ログアウトしました"
    end

    it "is redirect to root" do
      expect(response).to redirect_to root_path
    end
  end

end
