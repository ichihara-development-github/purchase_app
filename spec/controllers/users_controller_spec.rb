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
          id: normal_user}.to change(User, :count).by(-1)
        end

        it "assign the danger message to flash" do
          delete :destroy,id: normal_user
          expect(flash[:success]).to eq "ユーザーを削除しました"
        end

      end

      context "target user has admin attribute" do

        it "Was not removed in the database" do
          expect{
          delete :destroy,
          id: admin_user}.to change(User, :count).by(0)
        end

        it "assign the danger message to flash" do
          delete :destroy,id: admin_user
          expect(flash[:warning]).to eq "自分と管理者は削除できません"
        end

      end

    end

    context "current_user is not admin" do
      before{delete :destroy, id: normal_user}
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
      let!(:normal_user){create(:normal_user)}
      before{get :management}
      it_behaves_like "redirect to root if user is not seller"
    end
  end

end
