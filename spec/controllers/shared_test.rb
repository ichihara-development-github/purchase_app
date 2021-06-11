module Shared_test

  def login(id)
    @user = User.find(id)
    allow(controller)
      .to receive(:current_user)
      .and_return(@user)
    session[:user_id] = @user.id
  end


  shared_examples "redirect to root if user is not admin" do
    it "is redirect to root?" do
      expect(response).to redirect_to root_path
    end

    it "assign the danger message to flash" do
      expect(flash[:danger]).to eq "管理者権限がありません"
    end
  end

  shared_examples "redirect to root if user is not seller" do
    it "is redirect to login form?" do
      expect(response).to redirect_to root_path
    end

    it "assign the danger message to flash" do
      expect(flash[:danger]).to eq "オーナー権限がありません"
    end
  end

  shared_examples "redirect to root if user has not authority" do
    it "is redirect to login form?" do
      expect(response).to redirect_to root_path
    end

    it "assign the danger message to flash" do
      expect(flash[:danger]).to eq "権限がありません"
    end
  end

  shared_examples "redirect to loginpage if user has not logged in" do
    it "is redirect to login form?" do
      expect(response).to redirect_to new_session_path
    end

    it "assign the warning message to flash" do
      expect(flash[:warning]).to eq "Loginが必要です"
    end
  end

  shared_examples_for 'default_test' do |model, obj|

  let(:instance_name){model.name.downcase}
  obj ||= model.first

   describe "get new" do

     before do
       login(1)
       get :new
     end

     it "is http request success?" do
       expect(response).to have_http_status 200
     end
   end

   describe "post create" do
     before{login(1)}

     context "" do

       it "Was it saved in the database" do
         model.destroy_all
         expect{
         post :create,
         params: {"#{instance_name}": attributes_for(:"#{instance_name}")}}.to change(model, :count).by(1)
       end
     end
  end

   describe "get index" do
       before do
         login(1)
         get :index
       end

       it "assign the requested object to @object" do
         expect(assigns(:"#{instance_name.pluralize}")).to match_array(model.all)
       end

       it "is http request success?" do
         expect(response).to have_http_status 200
       end
   end


   describe "get show" do

    context "user has logged in" do
      before do
        login(1)
        get :show, params: {id: obj.id}
      end

      it "assign the requested object to @object" do
        expect(assigns(:"#{instance_name}")).to eq obj
      end

      it "is http request success?" do
        expect(response).to have_http_status 200
      end
    end

    # context "user has not logged in" do
    #   before do
    #     get :show, params: {id: obj.id}
    #   end
    #   it_behaves_like "redirect to loginpage if user has not logged in"
    # end
  end

   describe "get edit" do

     unless model == Store

       context "user is admin and" do
         before do
           login(1)
           get :edit, params: {id: obj.id}
         end

         it "assign the requested object to @object" do
           expect(assigns(:"#{instance_name}")).to eq obj
         end

         it "is http request success?" do
           expect(response).to have_http_status 200
           model.destroy_all
         end
       end

       context "user is not admin" do
         before do
           get :edit, params: {id: obj.id}
         end
         it_behaves_like "redirect to root if user has not authority"
       end

     end
   end

   # describe "pathch update" do
   #
   #   context "user has authority" do
   #     before do
   #       login
   #       patch :update, prams{id: obj, name: "updated"}
   #     end
   #
   #     it "is redirect to root?" do
   #       expect(response).to redirect_to "edit/#{instance_name}/#{obj.id}"
   #     end
   #
   #     it "assign the danger message to flash" do
   #       expect(flash[:danger]).to eq "権限がありません"
   #     end
   #
   #
   #   end
   #
   #   context "user has authority" do
   #     before{patch :update, prams{id: obj, name: "updated"}}
   #     it_behaves_like "redirect to root if user has not authority"
   #   end
   #
   # end
  end

end
