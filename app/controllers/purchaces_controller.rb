class PurchacesController < ApplicationController
  def new
    @productions = current_user.considering_productions
  end

  def create_notification(production, user)
      notification = current_user.active_notifications.new(
      production_id: id,
      user_id: user.id,
      action: "購入"
    )
    notification.save
  end


  def create

    begin
       ActiveRecord::Base.transaction do

       #決済------------------------------
       customer = Stripe::Customer.create(
         email: params[:stripe_email],
         source: params[:stripeToken]
         )

         charge = Stripe::Charge.create(
           customer: customer.id,
           amount: params[:amount],
           description: "商品の購入",
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


      @productions = current_user.considering_productions
      @productions.each do |production|
        current_user.purchaceds.create(production_id: production.id)
        create_notification(production, production.store.user)
      end
      current_user.baskets.destroy_all
      flash[:success] = "購入が完了しました"
      redirect_to productions_path
        end

    rescue Stripe::CardError => e
     flash[:danger] = "決済中にエラーが発生しました #{e.message}"


    rescue Stripe::InvalidRequestError => e
      flash.now[:danger] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      render "new"

    rescue Stripe::AuthenticationError => e
      flash.now[:danger] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
      render "new"

    rescue Stripe::StripeError => e
      flash.now[:danger] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
      render "new"

    rescue => e
      flash.now[:danger] = "エラーが発生しました#{e.message}"
      render "new"
    end

  end


end
