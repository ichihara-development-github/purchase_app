require "./spec/controllers/shared_test"
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

    include Shared_test
    FactoryBot.create(:user) unless User.any?
    FactoryBot.create(:store) unless Store.any?

    describe "default test" do
      store = Store.first
      Product.destroy_all
      @product = store.products.create(name:"product", description:"this is sample product for test",price:1000)
      it_behaves_like "default_test", Product, @product
    end

    describe "line up test" do

    end

    describe "search test" do

      it "free word serach" do

      end

      it "case search" do

      end
    end

  end
