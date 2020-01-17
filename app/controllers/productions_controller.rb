class ProductionsController < ApplicationController
    before_action :login_user?, only: [:show]
    before_action :has_store?, only: [:new, :edit_productions]
    before_action :set_production, only: [:show, :edit, :update, :destroy]
    before_action -> { has_authority?(@production.store.user) }, only: [:edit, :update, :destroy]
  
  def set_production
    @production = Production.find(params[:id])
  end
  
  def has_store?
   if current_user.seller && !current_user.store
    flash[:warning] = "Storeを所持していません"
    redirect_to new_store_path
   end
  end
  
  def new
   @production = Production.new
  end
  
  def create
     @store = Store.find(current_user.id)
     @production = @store.productions.build(production_params)
    if @production.save
      File.binwrite("app/assets/images/production/#{@production.id}.jpg", params[:production][:main_image].read)
      @production.update(main_image: "#{@production.id}.jpg")
      
     if params[:production][:sub_image1]
      File.binwrite("app/assets/images/production/#{@production.id}_1.jpg", params[:production][:sub_image1].read)
      @production.update(sub_image1: "#{@production.id}_1.jpg")
     end
     if params[:production][:sub_image2]
      File.binwrite("app/assets/images/production/#{@production.id}_2.jpg", params[:production][:sub_image2].read)
      @production.update(sub_image2: "#{@production.id}_2.jpg")
     end
      
      redirect_to productions_path
      flash[:success] = "商品の作成が完了しました"
    else
      flash[:error_messages] = @production.errors.full_messages
      render "new"
    end
  end
  
  def index
    @productions = Production.paginate(page: params[:page], per_page: 10)
    popular
  end
  
  def popular
    popular_list = Purchaced.group(:production_id).count(:production_id).sort_by{ | k, v | v }.reverse
    @popular = []
    popular_list.each do |popular|
      @popular << Production.find(popular[0])
    end
  end

  def show
    @comment = Comment.new
    @comments = @production.comments.order(created_at: "DESC")
  end
  
  def edit_productions
      @productions = current_user.store.productions
  end

  def edit
  end
  
  def update
      flash[:error_messages] = @production.errors.full_messages unless  @production.update(production_params)
    
    if params[:production][:main_image]
       File.binwrite("app/assets/images/production/#{@production.id}.jpg", params[:production][:main_image].read)
       @production.update(main_image: "#{@production.id}.jpg")
    end
    
   if params[:production][:sub_image1]
    File.binwrite("app/assets/images/production/#{@production.id}_1.jpg", params[:production][:sub_image1].read)
    @production.update(sub_image1: "#{@production.id}_1.jpg")
   end
   
   if params[:production][:sub_image2]
    File.binwrite("app/assets/images/production/#{@production.id}_2.jpg", params[:production][:sub_image2].read)
    @production.update(sub_image2: "#{@production.id}_2.jpg")
   end
   
    flash[:success] = "商品を編集しました"
    redirect_to edit_production_path(@production)
  end
  
  def destroy
    @production.destroy
    flash[:success] = "削除しました"
    redirect_to edit_productions_path
  end
  
  
  
 #-------------------------search-------------------------------
 
  def search

    if search_params.values.all?("")
      redirect_to productions_path
      
    else
      @productions = Production.search(search_params).paginate(page: params[:page], per_page: 10)
      if @productions.blank?
        flash[:warning] = "マッチする商品が見つかりませんでした" 
        redirect_to productions_path
      else
      
      popular
      render "index"
     end
    end
  end
  
    def free_search
        @productions = Production.free_search(params[:free_word]).paginate(page: params[:page], per_page: 10)
        popular
        render "index"
        if @productions.blank?
          flash.now[:notice] = "マッチする商品が見つかりませんでした"
          redirect_to productions_path
        end
    end
  
  
private
def production_params
  params.require(:production).permit(:name,:description, :price, :category, :main_image, :sub_image1, :sub_image2 )
end

def search_params
  params.permit(:min, :max, :store_id, :category)
end
end