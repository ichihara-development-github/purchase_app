class StoresController < ApplicationController
  
  # before_action :login?, only: [:show]
  before_action :login_user?, only: [:show]
  before_action :seller_user?, only: [:new, :edit]
  before_action :set_store, only: [:show, :edit, :update, :destroy]
  before_action -> { has_authority?(@store.user) }, only: [:update, :edit, :destroy]
  

  def set_store
    @store = Store.find(params[:id])
  end
  
  
  def new
    @store = Store.new
  end
  
  def create
   if current_user.store
      redirect_to root_path 
      flash[:danger] = "既にStoreを所持しています"
   else
  
    @store = current_user.build_store(store_params)
   
    if @store.save
      File.binwrite("app/assets/images/store/#{@store.id}.jpg", params[:store][:top_image].read)
      @store.update(top_image: "#{@store.id}.jpg")
      redirect_to stores_path
      flash[:success] = "Storeの作成が完了しました"
    else
      render "new"
      flash[:error_messages] = @store.errors.full_messages
    end
    
   end
  end
  
  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
    @productions = @store.productions
  end

  def edit
    
  end
  
  def update
    @store.update(store_params)
     if params[:store][:top_image]
        File.binwrite("app/assets/images/store/#{@store.id}.jpg", params[:store][:top_image].read)
        @store.update(top_image: "#{@store.id}.jpg")
     end
     redirect_to edit_store_path(@store)
  end
  
  
 
  
private
def store_params
  params.require(:store).permit(:name, :category, :description, :top_image, :user_id)
end
end
