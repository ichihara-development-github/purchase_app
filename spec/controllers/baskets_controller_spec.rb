require 'rails_helper'
require "./spec/controllers/shared_test"

RSpec.describe BasketsController, type: :controller do

  include Shared_test

  let(:user){User.first}

  describe "get index" do

    context "user has not logged in" do
      before{ get :index}
      it_behaves_like "redirect to loginpage if user has not logged in"
    end

    context "user has logged in" do
      before do
        login
        get :index
      end

      it "is http request success?" do
        expect(response).to have_http_status 200
      end

      it "assign the considering products to @products" do
        expect(assigns(:products)).to match_array(user.considering_products)
      end
    end

  end

  describe "post create" do
      before{ login}

    it "Was it saved in the database" do
      expect{post :create, params: {product_id: 1}, xhr: true}.to change(Basket, :count).by(1)
    end
  end

  describe "delete destory" do

  end

end
