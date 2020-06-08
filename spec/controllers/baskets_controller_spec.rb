require 'rails_helper'
require "./spec/controllers/shared_test"

RSpec.describe BasketsController, type: :controller do

  include Shared_test

  let(:user){User.first}

  describe "get index" do

    before{ get :index}

    context "user has not logged in" do
      it_behaves_like "redirect to loginpage if user has not logged in"
    end

    context "user has logged in" do
      before{ login }

      it "is http request success?" do
        expect(response).to have_http_status 200
      end

      it "assign the considering products to @products" do
        expect(assigns(:products)).to match_array(user.considering_products)
      end
    end

  end

  describe "post create" do

    it "Was it saved in the database" do
      expect{
      post :create,
      params: {basket: {product_id: 1}.to change(Basket, :count).by(1)
    end
  end

  describe "delete destory" do

  end

end
