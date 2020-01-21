require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
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
    
    
#-----------------------------------------------------Test---------------------------------------------------------
                        
                        
    describe "Get #index" do
        
        context "ユーザーが管理者でない場合"  do
            before do
                normal_user = create(:normal_user)
                sign_in normal_user
                get :index, id: normal_user
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
        end
        
        context "ユーザーが管理者の場合" do

            let(:jhon){ User.create(
                                     name: "Jhon",
                                     email: "jhon@example.com",
                                     password: "password")}
            before do
                sign_in user
                get :index, id: user
            end
               
            it_behaves_like "レスポンスが200になること"
             
             
            it "indexテンプレートが表示されていること" do
                 expect(response).to render_template :index
            end
            
            it "@productionsにすべてのproductionが割り当てられていること" do
                 expect(assigns(:users)).to match_array([user, jhon])
            end
        end
    end
    
    
    
     describe "Get #new" do
        before { get :new }
          
         it_behaves_like "レスポンスが200になること"
        
        it "newテンプレートをレンダリングすること" do
            expect(response).to render_template :new
        end
        
        it "新たなuserインスタンスがviewに渡されていること" do
            expect(assigns(:user)).to be_a_new User
        end
    end
    
    describe "Post #create" do
        context "正しいパラメーターが送られてきた場合" do
            let(:params) do
                {user: {
                        name: "user1",
                        email: "user1@user.com",
                        password: "password",
                        password_confiramation: "password",
                        profile_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample.jpg'))
                    }
                }
            end
            
            it "ユーザーが一人増えること" do
                expect {post :create, params: params}.to change(User, :count).by(1)
            end
            
            it "Productionのindexページにリダイレクトされること" do
                expect(post :create, params: params).to redirect_to(productions_path)
            end
            
        end
        
        context "無効なパラメーターが送られてきた場合" do
          before do
            post( :create, params: {
                    user: {
                        name: "user",
                        email: "user@user.com",
                        password: "pass",
                        password_confirmation: "incorrect_password"
                    }
              })
            
           end
            
            it "エラーメッセージに「Password confirmationとPasswordの入力が一致しません」が含まれていること" do
                expect(flash[:error_messages]).to include("Password confirmationとPasswordの入力が一致しません")
            end
            
            it "エラーメッセージに「Nameはすでに存在します」が含まれていること" do
                expect(flash[:error_messages]).to include("Nameはすでに存在します")
            end
            
            it "エラーメッセージに「Emailはすでに存在します」が含まれていること" do
                expect(flash[:error_messages]).to include("Emailはすでに存在します")
            end
            
            it "エラーメッセージに「Passwordは6文字以上で入力してください」が含まれていること" do
                expect(flash[:error_messages]).to include("Passwordは6文字以上で入力してください")
            end
            
            
            it "newテンプレートがレンダリングされていること" do
                expect(response).to render_template(:new)
            end
           
        end
    end
        
    describe "Get #show" do
        
        before do
         get :show, id: user.id
        end
            
         it_behaves_like "レスポンスが200になること"
             
         it "showテンプレートをレンダリングすること" do
          expect(response).to render_template :show
         end
        
         it "特定のユーザーインスタンスがviewに渡されていること" do
           expect(assigns(:user)).to eq(user)
         end
            
    end
        
    describe "Get #edit" do
        
        context "ユーザーに権限がない場合" do
            
            before do
                normal_user = create(:normal_user)
                sign_in normal_user
                get :edit, id: user
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
                
        end
        
        context "ユーザーに権限がある場合" do
        
            before do
                sign_in user
                get :edit, id: user
            end
              
            it  "リスポンスが200になること" do
                expect(response).to have_http_status(:ok)
            end
                 
            it "editテンプレートをレンダリングすること" do
              expect(response).to render_template :edit
            end
            
            it "特定のユーザーインスタンスががviewに渡されていること" do
               expect(assigns(:user)).to eq(user)
            end
         
        end
    end
        
    describe "Patch #update" do
        
        context "ユーザーに権限がない場合" do
            
            before do
                normal_user = create(:normal_user)
                sign_in normal_user
                patch(:update, params:
                     {id: user,
                    user: {
                            email: "user1@user1.com",
                            password: "password",
                            password_confiramation: "password",
                        }
                    })
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
                
        end
        
         context "ユーザーに権限がある場合" do
             
             before { sign_in user}
        
            context "正しいパラメーターが送られてきた場合" do
                
               before do
                   patch(:update, params:
                     {id: user.id,
                    user: {
                            email: "user1@user1.com",
                            password: "password",
                            password_confiramation: "password",
                        }
                    })
                 
                end
            
                
                it "特定のユーザーインスタンスがviewに渡されていること" do
                   expect(assigns(:user)).to eq(user)
                end
                
                it "userのeditページにリダイレクトされること" do
                    expect(response).to redirect_to(edit_user_path(user))
                end
                
                it "変更内容がupdateされていること" do
                    user.reload
                    expect(user.email).to eq("user1@user1.com")
                end
            end
        
            context "無効なパラメーターが送られてきた場合" do
              before do
                patch( :update, params: {
                    id: user.id,
                        user: {
                            password: "pass",
                            password_confirmation: "pasa"
                        }
                  })
                
               end
                
                it "エラーメッセージに「Passwordは6文字以上で入力してください」が含まれていること" do
                    expect(flash[:error_messages]).to include("Passwordは6文字以上で入力してください")
                end
                
                it "エラーメッセージに「Password confirmationとPasswordの入力が一致しません」が含まれていること" do
                    expect(flash[:error_messages]).to include("Password confirmationとPasswordの入力が一致しません")
                end
                
                it "newテンプレートがレンダリングされていること" do
                    expect(response).to render_template(:edit)
                end
               
            end
        end
    end
            
        
    describe "Delete #destroy" do
        
        context "ユーザーに権限がない場合" do
            
            before do
                normal_user = create(:normal_user)
                sign_in normal_user
                delete :destroy, id: user
            end
            
            it_behaves_like "ユーザーに権限がない場合の処理"
        end
        
        context "ユーザーに権限がある場合" do
            let!(:normal_user){create(:normal_user)}
            before do
                sign_in user
            end
                        
            it "特定のユーザーインスタンスがviewに渡されていること" do
                 delete :destroy, id: normal_user
               expect(assigns(:user)).to eq(normal_user)
            end
            
            it "ユーザーが１人削除されていること" do
               expect{delete :destroy, id: normal_user}.to change(User, :count).by(-1)
            end
            
            it "メッセージに「ご利用ありがとうございました」と表示されていること" do
                 delete :destroy, id: normal_user
                expect(flash[:success]).to eq("ご利用ありがとうございました")
            end
        end
    end
        
    describe "Get #management" do
        
        context "ユーザーに権限がない場合" do
            
            before do
                normal_user = create(:normal_user)
                sign_in normal_user
                get :management, id: normal_user
            end
            
             it "root_pathにダイレクトされること" do
              expect(response).to redirect_to root_path
            end
            
            it "エラーメッセージに「権限がありません」が含まれていること" do
                expect(flash[:danger]).to include("オーナー権限がありません")
             end
        end
        
        context "ユーザーに権限がある場合" do

            before do
                sign_in user
                get :management, id: user
            end
          
            it  "リスポンスが200になること" do
               expect(response).to have_http_status(:ok)
            end
            
            it "managementテンプレートをレンダリングすること" do
                expect(response).to render_template :management
            end
        end
    
    end
    
    describe "Get #registration" do
        
        before do
             sign_in user
             get :registration
        end
        
        it_behaves_like "レスポンスが200になること"
        
        it "managementテンプレートをレンダリングすること" do
            expect(response).to render_template :registration
        end
    end
    
end


    
