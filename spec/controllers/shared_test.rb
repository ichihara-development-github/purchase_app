module Shared_test

  def login
    @user = User.first
    allow(controller)
      .to receive(:current_user)
      .and_return(@user)
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


  shared_examples "redirect to root if user has not autheority" do
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
  end

  shared_examples_for 'default_test' do |model, obj|

  let(:instance_name){model.name.downcase}
  obj ||= model.first

   describe "get new" do
     before {get :new}

     it "is http request success?" do
       expect(response).to have_http_status 200
     end
   end

   describe "post create" do
     before{login}

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
     unless model == Product
       before {get :index
               login}
       it "assign the requested object to @object" do
         expect(assigns(:"#{instance_name.pluralize}")).to match_array(model.all)
       end

       it "is http request success?" do
         expect(response).to have_http_status 200
       end
     end
   end


   describe "get show" do

    context "user has logged in" do
      before do
        login
        get :show, id: obj.id
      end

      it "assign the requested object to @object" do
        expect(assigns(:"#{instance_name}")).to eq obj
      end

      it "is http request success?" do
        expect(response).to have_http_status 200
      end
    end

    context "user has not logged in" do
      before { get :show, id: obj.id}

      it_behaves_like "redirect to loginpage if user has not logged in"
    end

  end

   describe "get edit" do
     before {get :edit, id: obj.id}
     debugger

     context "user is admin" do
       before{login}
       it "assign the requested object to @object" do
         expect(assigns(:"#{instance_name}")).to eq obj
       end

       it "is http request success?" do
         expect(response).to have_http_status 200
         model.destroy_all
       end
     end

       context "user is not admin" do
         it_behaves_like "redirect to root if user has not autheority"
       end
   end

  end

end
