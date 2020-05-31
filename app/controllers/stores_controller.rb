class StoresController < ApplicationController

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
    @store.address ||= "東京"

    if @store.save
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
    @products = @store.products
    @distance = distance(current_user.latitude, current_user.longitude, @store.latitude, @store.longitude)
  end

  def edit
  end

  def update
    @store.update(store_params)
    redirect_to store_path(@store)
  end




private
def store_params
  params.require(:store).permit(:name, :category, :description, :address, :top_image, :user_id)
end
end
