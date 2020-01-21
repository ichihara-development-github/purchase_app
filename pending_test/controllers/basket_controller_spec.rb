require 'rails_helper'

RSpec.describe BasketsController, type: :controller do

include AuthenticationHelper

     shared_examples "レスポンスが200になること" do
        it "レスポンスが200になること" do
               expect(response).to have_http_status(:ok)
         end
     end
    
     shared_examples "ユーザーに権限がない場合の処理" do
            
        it "root_pathにダイレクトされること" do
            expect(response).to redirect_to root_path
        end
        
        it "エラーメッセージに「権限がありません」が含まれていること" do
            expect(flash[:danger]).to include("権限がありません")
         end
    end
    
    shared_examples "ユーザーがログインしていない場合の処理" do
        
        it "new_session_pathにダイレクトされること" do
            expect(response).to redirect_to new_session_path 
        end
        
        it "エラーメッセージに「Loginが必要です」が含まれていること" do
              expect(flash[:warning]).to include("Loginが必要です")
         end
      
        
    end
    
    let!(:user){create(:user)}
    let!(:normal_user){create(:normal_user)}
    let!(:store){create(:store)}
    let!(:production){create(:production)}
    let!(:basket){create(:basket)}
    
    describe "Get #index" do
        
        context "ユーザーがログインしている場合" do
            
            before do
                sign_in user
                get :index
            end
            
            let(:baskets){ user.considering_productions}
            
            it "@productionsにユーザーに紐づくすべてのproductionが割り当てられていること" do
                expect(assigns(:productions)).to eq(baskets)
            end
            
        end
        
        context "ユーザーがログインしていない場合" do
            before { get :index }
            it_behaves_like "ユーザーがログインしていない場合の処理"
        end
    end
    
    describe "Post #create" do
        
        context "ユーザーがログインしている場合" do
            
            before { sign_in user }
            
            it "Basketが一つ増えていること" do
                expect{ post :create, production_id: production}.to change(Basket, :count).by(1)
            end
            
        end
        
        context "ユーザーがログインしていない場合" do
            before { get :index }
            it_behaves_like "ユーザーがログインしていない場合の処理"
        end
    end
    
    describe "Delete #destroy" do
        
         context "ユーザーがログインしていない場合" do
            before { delete :destroy, production_id: production.id }
            it_behaves_like "ユーザーがログインしていない場合の処理"
        end
        
        context "ユーザーがログインしている場合" do
            
             before { sign_in user }
            
            it "@productionに特定のproductionが割り当てられていること" do
                delete :destroy, production_id: production.id
                expect(assigns(:production)).to eq(production)
            end
            
            it "Basketの数が一つ減っていること" do
                expect{delete out_basket_path(production.id)}.to
            end
            
        end
        
    end
    
    describe "Post #add" do
        
        context "ユーザーがログインしている場合" do
            
             before do
                sign_in user
                post :add, id: production.id
            end
            
            it "@production特定のproductionが割り当てられていること" do
                expect(assigns(:production)).to eq(production)
            end
            
        end
        
        context "ユーザーがログインしていない場合" do
            before { get :index }
            it_behaves_like "ユーザーがログインしていない場合の処理"
        end
    end
    
    describe "Post #delete" do
        
        context "ユーザーがログインしていない場合" do
            before { post :delete }
            it_behaves_like "ユーザーがログインしていない場合の処理"
        end
        
        context "ユーザーがログインしている場合" do
            
             before { sign_in user }
             end
            
            it "@basketに特定のbasketが割り当てられていること" do
                post :delete, params{format{ production.id}}
                expect(assigns(:basket)).to eq(basket)
            end
            
            it "Basketの数が一つ減っていること" do
                expect{post :delete, id: production}.to change(Basket, :count).by(-1)
            end
            
        end
        
            
    end
  
    
