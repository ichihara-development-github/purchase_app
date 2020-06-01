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

  describe "post login" do

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
        login
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

end
