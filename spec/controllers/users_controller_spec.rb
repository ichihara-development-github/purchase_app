require "./spec/controllers/shared_test"
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  include Shared_test

  describe "default test" do
    it_behaves_like "default_test", User
  end


  describe "delete #destroy" do

    let!(:normal_user){create(:normal_user)}
    let!(:admin_user){create(:user2)}

    context "user is admin" do
      before{login(1)}

      context "target user is normal user" do

        it "Was it removed in the database" do
          expect{
          delete :destroy,
          params: {id: normal_user}}.to change(User, :count).by(-1)
        end

        it "assign the danger message to flash" do
          delete :destroy,params: {id: normal_user}
          expect(flash[:success]).to eq "ユーザーを削除しました"
        end

      end

      context "target user has admin attribute" do

        it "Was not removed in the database" do
          expect{
          delete :destroy,
          params: {id: admin_user}}.to change(User, :count).by(0)
        end

        it "assign the danger message to flash" do
          delete :destroy,params: {id: admin_user}
          expect(flash[:warning]).to eq "自分と管理者は削除できません"
        end

      end

    end

    context "current_user is not admin" do
      before do
        delete :destroy, params: {id: normal_user}
      end
      it_behaves_like "redirect to root if user is not admin"
    end
  end

  describe "get management" do

    context "user is seller" do
      before do
        login(1)
        get :management
      end

      it "is http request success?" do
        expect(response).to have_http_status 200
      end
    end

    context "user has not seller attribute" do
      let!(:has_no_store){create(:has_no_store)}
      before do
        login(4)
        get :management
      end

      it "is redirect to login form?" do
        expect(response).to redirect_to new_store_path
      end

      it "assign the danger message to flash" do
        expect(flash[:warning]).to eq "店舗を所持していません"
      end
    end
  end

end
