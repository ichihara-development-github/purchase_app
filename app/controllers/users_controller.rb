class UsersController < ApplicationController
  before_action :login_user?, only: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :has_store?, only: :management
  before_action -> { has_authority?(@user) }, only: [:update, :edit, :management]
  before_action :admin_user?, only: [:index, :destroy]

  def set_user
    @user = User.find(params[:id])
  end

#-------------------------------------------------------------------------------

  def index
    @users = User.all
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.address ||= "東京"
    if @user.save
      flash[:success] = "ユーザー登録が完了しました"
      session[:user_id] = @user.id
      redirect_to products_path
    else
      flash[:error_messages] = @user.errors.full_messages
      render "new"
    end
  end

  def show

  end

  def edit
  end

  def update
    if @user.update(user_params)
      @user.update(address: "東京") unless params[:user][:address].present?
      flash[:success] = "編集が完了しました"
      redirect_to edit_user_path(@user)
    else
      flash[:error_messages] = @user.errors.full_messages
      render "edit"
    end

  end

  def destroy
     if (current_user == @user) or @user.admin
       flash[:warning] = "自分と管理者は削除できません"
       redirect_to users_path
     else
      if @user.destroy
          flash[:success] = "ユーザーを削除しました"
          redirect_to users_path
      else
          flash[:warning] = "上手くいきませんでした"
          render "index"
      end
     end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 8)
    render "follow_and_followers"
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 8)
    render "follow_and_followers"
  end

  def management
  end

  def registration
  end


  def payment
    begin
       ActiveRecord::Base.transaction do

        unless current_user.seller
          current_user.toggle!(:seller)
        else
           flash[:danger] = "既にオーナーです"
           redirect_to complete_payment_path
           raise ActiveRecord::Rollback
        end

       #決済------------------------------
       customer = Stripe::Customer.create(
         email: params[:stripe_email],
         source: params[:stripeToken]
         )

         charge = Stripe::Charge.create(
           customer: customer.id,
           amount:1000,
           description: "オーナー権限の付与",
           currency: "jpy",
           receipt_email: params[:stripe_email],
           #falseだと仮払い
           capture: true)

          payment = current_user.payment.build(
          email:                             customer.email,
          description:                       charge.description,
          currency:                          charge.currency,
          customer_id:                       customer.id,
          charge_id:                         charge.id,
          payment_date:                      Time.current,
          commission:                        (charge.amount * 0.036).round,
          profit_after_subtract_commission:  charge.amount - (charge.amount * 0.036).round,
          )
          payment.save!

          redirect_to complete_payment_path
          flash.now[:success] = "オーナー登録が完了しました"
        end

    rescue Stripe::CardError => e
     flash[:danger] = "決済中にエラーが発生しました。#{e.message}"

    rescue Stripe::InvalidRequestError => e
      flash.now[:danger] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      render "registration"

    rescue Stripe::AuthenticationError => e
      flash.now[:danger] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
      render "registration"

    rescue Stripe::StripeError => e
      flash.now[:danger] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
      render "registration"

    rescue => e
      flash.now[:danger] = "エラーが発生しました#{e.message}"
      render "registration"
    end
  end

 def complete_payment
 end



#-------------------------------------------------------------------------------
private

def user_params
  params.require(:user).permit(:name, :email, :introduce, :address,:profile_image, :password, :password_confirmation)
end

end
