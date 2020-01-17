require 'rails_helper'

RSpec.describe ProductionsController, type: :controller do
    
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
    let!(:normal_user){create(:normal_user)}
    let!(:store){create(:store)}
    let!(:production){create(:production)}
    let!(:comment){create(:comment)}
    
    
#-----------------------------------------------------Test---------------------------------------------------------
    
          
    describe "Get #index" do

        let(:car){ Production.create(
                                         name: "car",
                                         description: "This is a car",
                                         price: 1,
                                         main_image: "blabla",
                                         store_id: 1)}
        let(:bike){ Production.create(
                                         name: "bike",
                                         description: "This is a bike",
                                         price: 1,
                                         main_image: "blabla",
                                         store_id: 1)}
        before {get :index}
           
         it_behaves_like "レスポンスが200になること"
         
         
        it "indexテンプレートが表示されていること" do
             expect(response).to render_template :index
        end
        
        it "@productionsにすべてのproductionが割り当てられていること" do
             expect(assigns(:productions)).to match_array([production, car,bike])
 
        end
    end
    
    describe "Get #new" do
        
        context "ユーザーがStoreを所持していない場合" do
            
            before do
                has_no_store = create(:has_no_store)
                sign_in has_no_store
                get :new , id: has_no_store
            end
            
            it "new_store_pathにリダイレクトされること" do
                expect(response).to redirect_to new_store_path
            end
            
            it "エラーメッセージに「Storeを所持していません」が含まれていること" do
                expect(flash[:warning]).to include("Storeを所持していません")
            end
        end
        
        context "ユーザーがStoreを所持している場合" do
            
            before do
                sign_in user
                get :new , id: user
            end
          
            it_behaves_like "レスポンスが200になること"
            
            it "newテンプレートをレンダリングすること" do
                expect(response).to render_template :new
            end
            
            it "新たなuserインスタンスがviewに渡されていること" do
                expect(assigns(:production)).to be_a_new Production
            end
        end
    end
    
    describe "Post #create" do
        
        before { sign_in user }
        
        context "正しいパラメーターが送られてきた場合" do
            
            let(:params) do
                {
                    production: {
                        name: "production1",
                        price: 1,
                        description: "This is production1",
                        main_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.jpg')),
                        store_id:1,
                    }
                }
            end
            
            it "Productionが一つ増えること" do
                expect{post :create, params: params}.to change(Production, :count).by(1)
            end
            
            it "Productionのindexページにリダイレクトされること" do
                expect(post :create, params: params).to redirect_to(productions_path)
            end
            
        end
        
        context "無効なパラメーターが送られてきた場合" do
            
           before do
              
            post( :create, params: {
                    production: {
                        name: "production",
                        price: 1000000,
                        description: "",
                        main_image: "",
                        store_id:1,
                    }
              })
              
           end
           
            it "エラーメッセージに「Nameはすでに存在します」が含まれていること" do
                expect(flash[:error_messages]).to include("Nameはすでに存在します")
            end
          
            it "エラーメッセージに「Priceは1000000より小さい値にしてください」が含まれていること" do
                expect(flash[:error_messages]).to include("Priceは1000000より小さい値にしてください")
            end
            
            it "エラーメッセージに「Descriptionを入力してください」が含まれていること" do
                expect(flash[:error_messages]).to include("Descriptionを入力してください")
            end
            
           it "エラーメッセージに「Main imageを入力してください」が含まれていること" do
                expect(flash[:error_messages]).to include("Main imageを入力してください")
           end
       
        end
    end
    
    describe "Get #show" do
        
        
        context "ユーザーがログインしていない場合" do
            
             before {get :show, id: production.id}
            
            it "エラーメッセージに「Loginが必要です」が含まれていること" do
                expect(flash[:warning]).to include("Loginが必要です")
            end
            
            it "new_session_pathにリダイレクトされること" do
                 expect(flash[:warning]).to redirect_to new_session_path
            end
        end
        
        context "ユーザーがログインしている場合" do
            
            let!(:comment2){create(:comment2)}
    
            before do
              sign_in user
              get :show, id: production.id 
            end 
                
             it_behaves_like "レスポンスが200になること"
                 
             it "showテンプレートをレンダリングすること" do
              expect(response).to render_template :show
             end
            
             it "特定のProductionインスタンスがviewに渡されていること" do
               expect(assigns(:production)).to eq(production)
             end
             
             it "@commentsに@productionに関連付けられているすべてのcommentが割り当てられていること" do
                expect(assigns(:comments)).to match_array([comment, comment2])
             end
             
              it "特定のインスタンスがviewに渡されていること" do
               expect(assigns(:comment)).to be_a_new Comment
             end
             
             describe "comment #new" do
                 
                xit "newテンプレートをレンダリングすること" do
                    expect(subject).to render_template("comments/comment")
                end
                
                it "新たなuserインスタンスがviewに渡されていること" do
                    expect(assigns(:comment)).to be_a_new Comment
                end
             end
             
            describe "comment Post #create" do
            
                context "正しいパラメーターが送られてきた場合" do
                    
                    let(:params) do
                        {
                            production: {
                               user_id: 1,
                               production_id: 1,
                               content: "コメントコメント"
                            }
                        }
                    end
                    
                    xit "Commentが一つ増えること" do
                        expect{post comments_path, params:{user_id: 1, production_id: 1, content: "コメント"}}.to change(Comment, :count).by(1)
                    end
                    
                    it "@commentsに@productionに関連付けられているすべてのcommentが割り当てられていること" do
                        post :create, params: params
                        expect(assigns(:comments)).to match_array([comment, comment2])
                    end
                    
                end
                
                context "無効なパラメーターが送られてきた場合" do
                    
                   before do
                      
                    post( :create, params: {
                            production: {
                               user_id: 1,
                               production_id:2
                            }
                      })
                      
                   end
                  
                    xit "エラーメッセージに「Contentを入力してください」が含まれていること" do
                        expect(flash[:error_messages]).to include("Contentを入力してください")
                    end
               
                end
            end
        end
            
        describe "comment Delete #destroy" do
            
           context "ユーザーに権限がない場合" do
        
           before do
                sign_in normal_user
                delete :destroy, id: comment
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
            
        end
        
        context "ユーザーに権限がある場合" do
            
            before do
                sign_in user
            end
                        
            xit "特定のユーザーインスタンスがviewに渡されていること" do
               delete comment_path, id: comment
               expect(assigns(:comment)).to eq(comment)
            end
            
            xit "productionが１つ削除されていること" do
               expect{delete comments_path}.to change(Comment, :count).by(-1)
            end
            

         end
            
    end
    
    describe "Get #edit_productions" do
        
         context "ユーザーがStoreを所持していない場合" do
            before do
                has_no_store = create(:has_no_store)
                sign_in has_no_store
                get :edit_productions, id: has_no_store
            end
            
            it "エラーメッセージに「Storeを所持していません」が含まれていること" do
                expect(flash[:warning]).to include("Storeを所持していません")
            end
            
            it "new_session_pathにリダイレクトされること" do
                 expect(response).to redirect_to new_store_path
            end
            
        end
        
        context "ユーザーがStoreを所持している場合" do
            
            before do
              sign_in user
              get :edit_productions, id: user
            end 
                
             it_behaves_like "レスポンスが200になること"
                 
             it "edit_productionsテンプレートをレンダリングすること" do
              expect(response).to render_template :edit_productions
             end
            
         end
    end
    
    
    
    describe "Get #edit" do
        
        context "ユーザーに権限がない場合" do
            
            before do
                sign_in normal_user
                get :edit, id: production.id
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
            
        end
        
        
        context "ユーザーに権限がある場合" do
            before do
                sign_in user
                get :edit, id: production.id
             end
            
            it_behaves_like "レスポンスが200になること"
            
            it "editテンプレートをレンダリングすること" do
              expect(response).to render_template :edit
            end
            
            it "特定のProductionインスタンスがviewに渡されていること" do
              expect(assigns(:production)).to eq(production)
            end
        end
         
    end
    
    describe "Patch :update" do
        context "ユーザーに権限がない場合" do
            
            before do
                sign_in normal_user
                patch( :update, params: {
                        id: production.id,
                        production: {
                            name: "production_updated"
                        }
                    })
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
            
        end
        
        context "ユーザーに権限がある場合" do
            
            context "正しいパラメーターが送られてきた場合" do
                before do
                    
                    sign_in user
                    patch( :update, params: {
                        id: production.id,
                        production: {
                            name: "production_updated"
                        }
                    })
                end
        
                
                it "特定のユーザーインスタンスがviewに渡されていること" do
                   expect(assigns(:production)).to eq(production)
                end
                
                it "productionのeditページにリダイレクトされること" do
                    expect(response).to redirect_to(edit_production_path(production))
                end
                
                it "変更内容がupdateされていること" do
                    production.reload
                    expect(production.name).to eq("production_updated")
                end
             end
             
             context "無効なパラメーターが送られてきた場合" do
                 
                 before do
                     
                    sign_in user
                    production2 = create(:production2)
                    patch( :update, params: {
                        id: production2.id,
                        production: {
                            name: "production",
                            price: 1000000
                        }
                    })
                 end
                 
                it "エラーメッセージに「Nameはすでに存在します」が含まれていること" do
                    expect(flash[:error_messages]).to include("Nameはすでに存在します")
                end
                
                 it "エラーメッセージに「Priceは1000000より小さい値にしてください」が含まれていること" do
                    expect(flash[:error_messages]).to include("Priceは1000000より小さい値にしてください")
                end
        
            end
        end
    end
    
    describe "Delete #destroy" do
        
        context "ユーザーに権限がない場合" do
            
            before do
                sign_in normal_user
                delete :destroy, id: production
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
            
        end
        
        context "ユーザーに権限がある場合" do
            
            before do
                sign_in user
            end
                        
            it "特定のユーザーインスタンスがviewに渡されていること" do
                delete :destroy, id: production
               expect(assigns(:production)).to eq(production)
            end
            
            it "productionが１つ削除されていること" do
               expect{delete :destroy, id: production}.to change(Production, :count).by(-1)
            end
            
            it "メッセージに「削除しました」と表示されていること" do
                delete :destroy, id: production
                expect(flash[:success]).to eq("削除しました")
            end
            
            it "edit_productions_pathにリダイレクトされていること" do
                delete :destroy, id: production
                expect(response).to redirect_to edit_productions_path
            end
           
        end
    end
end
end
