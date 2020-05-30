require "./spec/controllers/shared_test"
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  include Shared_test

  describe "default test" do
    it_behaves_like "default_test", User
  end


  describe "delete #destroy" do

    let!(:normal_user){create(:normal_user)}

    context "user is admin" do
      before{login}

        it "Was it removed in the database" do
          expect{
          delete :destroy,
          id: normal_user}.to change(User, :count).by(-1)
        end

        it "assign the danger message to flash" do
          expect(flash[:success]).to match "ユーザーを削除しました"
        end

    end

    context "current_user is not admin" do
      before{delete :destroy, id: normal_user}
      it_behaves_like "redirect to root if user is not admin"
    end
  end

  it "get management" do
    login
    get :management
    expect(response).to have_http_status 200
  end


  describe "follow test" do

  end

end
