require "./spec/controllers/shared_test"
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

    include Shared_test

    shared_examples "searched products are not found" do
      it "assign the danger message to flash" do
        expect(flash[:warning]).to eq "マッチする商品が見つかりませんでした"
      end

      it "is redirect to index?" do
        expect(response).to redirect_to products_path
      end
    end

    shared_examples "it assign all products to @products" do
      it "" do
        expect(assigns(:products)).to match_array(Product.all)
      end
    end

    # describe "default test" do
    #   Product.destroy_all
    #   product = FactoryBot.create(:product)
    #   it_behaves_like "default_test", Product, product
    # end

    describe "search test" do
      let!(:product){Product.find(1)}
      let!(:product2){create(:product2)}

      describe "free word serach" do

        context "sent params are blank" do
          before do
            get :free_search, params: {free_word: ""}
          end

          it_behaves_like "it assign all products to @products"

          it "is rendering index templates" do
            expect(response).to render_template("index")
          end
         end

        context "sent params are exist" do

          context "product was found" do
            before do
              get :free_search, params: {free_word: "product2"}
            end

            it "it assign the found product to @products" do
              expect(assigns(:products)).to match_array(product2)
            end

            it "is rendering index templates" do
              expect(response).to render_template("index")
            end
          end

          context "product was not found" do
            before do
              get :free_search, params: {free_word: "product3"}
            end

            it "is redirect to index?" do
              expect(response).to redirect_to products_path
            end
          end
        end

      end

      describe "multiple conditional search" do
        context "if sent params are invalid" do

          context "sent params are all blank" do
            before do
              get :search, params: {min: "hoge"}
            end

            it "is redirect to index?" do
              expect(response).to redirect_to products_path
            end
          end

          context "character was entered in the integer field" do
            before do
              get :search, params: {min: "hoge"}
            end

            it_behaves_like "searched products are not found"

          end

          context "sent values max and min have been reversed" do
            before do
              get :search, params: {min:1000, max: 1}
            end

            it_behaves_like "searched products are not found"
          end

        end

        context "if sent params are valid" do

          context "searched products were found" do

            context "search by categories" do
              before do
                get :search, params: {store_id: 1}
              end

              it "it assign the found product to @product" do
                expect(assigns(:products)).to contain_exactly(product, product2)
              end

              it "is rendering index templates" do
                expect(response).to render_template("index")
              end
            end

            context "search by amount range" do
              before do
                get :search, params: {min:1, max: 999}
              end

              it "it assign the found product to @product" do
                expect(assigns(:products)).to match_array(product)
              end

              it "is rendering index templates" do
                expect(response).to render_template("index")
              end

            end

            context "search by stores" do
              before do
                get :search, params: {category: "food"}
              end

              it "it assign the found product to @product" do
                expect(assigns(:products)).to match_array(product2)
              end

              it "is rendering index templates" do
                expect(response).to render_template "index"
              end

            end

            context "search by multiple condition" do
              before do
                get :search, params: {category: "food", max: 2000, store_id: 1}
              end

              it "it assign the found product to @product" do
                expect(assigns(:products)).to match_array(product2)
              end

              it "is rendering index templates" do
                expect(response).to render_template "index"
              end

            end
          end

          context "searched products were not found" do
            before do
              get :search, params: {category: "ファッション", max: 1000, store_id: 1}
            end
            it_behaves_like "searched products are not found"
          end
        end
      end
    end

  end
