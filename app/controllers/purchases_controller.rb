class PurchasesController < ApplicationController

  def new
    @baskets = current_user.baskets
  end


  def create

    @baskets = current_user.baskets

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

         current_user.baskets.each do |basket|
         product = basket.product
           if  product.count < basket.count
             flash[:waring] = "#{product.name}の在庫が不足しています。"
             redirect_to baskets_path
             return false
           else
             product.count -= basket.count
             current_user.purchases.create(product_id: product.id,count: basket.count)
             create_notification(product.store.user, product, "", "purchase")
           end
         end

         current_user.baskets.destroy_all
         flash[:success] = "購入が完了しました"
         redirect_to baskets_path
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

  def check_product_stocks
  end

end
