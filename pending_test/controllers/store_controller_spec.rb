require 'rails_helper'

RSpec.describe StoresController, type: :controller do
    
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
        
        let!(:user){create(:user)}
        let!(:has_no_store){create(:has_no_store)}
        let!(:store){create(:store)}
        
#-----------------------------------------------------Test---------------------------------------------------------
    
    describe "Get #index" do
        
        let(:store2){Store.create(id:2,
                              name: "car_shop",
                              description: "This is my car_shop",
                              top_image: "top_image",
                              user_id: 1)}
        
        before {get :index}
         
         
        it "indexテンプレートが表示されていること" do
            expect(response).to render_template :index
        end
        
        it_behaves_like "レスポンスが200になること"
    
                              
        it "@storesにすべてのstoreが割り当てられていること" do
            expect(assigns(:stores)).to match_array([store, store2])
        end
    end
    
    
     describe "Get #new" do
         
         context "ユーザーに権限がない場合" do
            before do
                normal_user = create(:normal_user)
                sign_in(normal_user)
                get :new, id: normal_user
            end
            it_behaves_like "ユーザーに権限がない場合の処理"
        end

         
         context "ユーザーに権限がある場合" do
            before do
                sign_in user
                get :new , id: user
            end
              
            it_behaves_like "レスポンスが200になること"
            
            it "newテンプレートをレンダリングすること" do
                expect(response).to render_template :new
            end
            
            it "新たなstoreインスタンスがviewに渡されていること" do
                expect(assigns(:store)).to be_a_new Store
            end
        end
    end
    
    describe "Post #create" do
        
        context "ユーザーがStoreを所持している場合" do
            
            before do
                sign_in user
                post( :create, params: 
                        {store: {
                            name: "store1",
                            description: "This is the production1",
                            top_image: "top_image"
                        }
                  })
               end
                
             it "root_pathにリダイレクトされること" do
                 expect(response).to redirect_to root_path
             end
             
             it "エラーメッセージに「既にStoreを所持しています」が含まれていること" do
                 expect(flash[:danger]).to include("既にStoreを所持しています")
            end
        end
        
         
        context "ユーザーがStoreを所持していない場合" do
            
            before {sign_in has_no_store}
        
            context "正しいパラメーターが送られてきた場合" do
                
                let(:params) do {
                    store: {
                        name: "store1",
                        description: "This is the production1",
                        top_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.jpg')) }
                }
               end
               
                
                it "Storeが一つ増えること" do
                   expect{post :create, params: params}.to change(Store, :count).by(1)
                end
                
                it "Storeのindexページにリダイレクトされること" do
                    expect(post :create, params: params).to redirect_to stores_path
                end
                
            end
            
            context "無効なパラメーターが送られてきた場合" do
                
              before do
                post( :create, params: 
                        {store: {
                            name: "store",
                            user_id: 1
                        }
                  })
               end
                
                it "エラーメッセージに「Nameはすでに存在します」が含まれていること" do
                    expect(flash[:error_messages]).to include("Nameはすでに存在します")
                end
                
                it "エラーメッセージに「Descriptionを入力してください」が含まれていること" do
                expect(flash[:error_messages]).to include("Descriptionを入力してください")
                end
                
               it "エラーメッセージに「Top imageを入力してください」が含まれていること" do
                    expect(flash[:error_messages]).to include("Top imageを入力してください")
               end
                
                it "newテンプレートがレンダリングされていること" do
                    expect(response).to render_template(:new)
                end
               
            end
        end
     end  
    describe "Get #show" do
        
        before do
         get :show, id: store.id
        end
            
         it_behaves_like "レスポンスが200になること"
             
         it "showテンプレートをレンダリングすること" do
          expect(response).to render_template :show
         end
        
         it "特定のインスタンスがviewに渡されていること" do
           expect(assigns(:store)).to eq(store)
         end
            
        end
        
        describe "Get #edit" do
        
          context "ユーザーに権限がない場合" do
              
            before do
                normal_user = create(:normal_user)
                sign_in(normal_user)
                get :edit, id: normal_user
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
          end
          
          
          context "ユーザーに権限がある場合" do
              
            before do
                sign_in(user)
                get :edit, id: user
            end
            
             it_behaves_like "レスポンスが200になること"
             
             it "editテンプレートをレンダリングすること" do
              expect(response).to render_template :edit
             end
             
             it "特定のユーザーインスタンスががviewに渡されていること" do
               expect(assigns(:store)).to eq(store)
             end
           end
        
    end
        
    describe "Patch #update" do
        
        context "正しいパラメーターが送られてきた場合" do
            
            let(:params) do
                {id: 1,
                store: {
                name: "store",
                description: "This is the store",
                user_id: 1
                    }
                }
            end
            
             before do
                sign_in user
                get :new , id: user
            end
            
        it "特定のユーザーインスタンスがviewに渡されていること" do
           patch :update, params: params
           expect(assigns(:store)).to eq(store)
        end
        
        it "storeのeditページにリダイレクトされること" do
              patch :update, id: store, params: params
            expect(response).to redirect_to(edit_store_path(store))
        end
        
        it "変更内容がupdateされていること" do
            patch :update, params: params
            store.reload
            expect(store.description).to eq("This is the store")
        end
    end
        
        
    end
    
        # describe "Delete #destroy" do
            
        #     it "ユーザーが１人削除されていること" do
            
        #         delete :destroy, id: @store.id
        #   　　 expect{delete :destroy, id:@store}.to change(Store, :count).by(-1)
        #     end
        # end
        
end
  
