class PurchasesController < ApplicationController

  def new
    @baskets = current_user.baskets
  end


  def create
    @baskets = current_user.baskets

    begin
       ActiveRecord::Base.transaction do
         return redirect_to new_purchase_path unless check_product_stocks

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
           customer_id:                       current_user.id,
           charge_id:                         charge.id,
           payment_date:                      Time.current,
           commission:                        (charge.amount * 0.036).round,
           profit_after_subtract_commission:  charge.amount - (charge.amount * 0.036).round,
           )
           payment.save!

         current_user.baskets.destroy_all
         flash[:success] = "購入が完了しました"
         redirect_to baskets_path
        end

       rescue Stripe::CardError => e
         flash[:danger] = "決済中にエラーが発生しました #{e.message}"

      rescue Stripe::InvalidRequestError => e
        flash.now[:danger] = "InvalidRequestError#{e.message}"
        render "new"

      rescue Stripe::AuthenticationError => e
        flash.now[:danger] = "AuthenticationError #{e.message}"
        render "new"

      rescue Stripe::StripeError => e
        flash.now[:danger] = "StripeError #{e.message}"
        render "new"

      rescue => e
        flash.now[:danger] = "エラーが発生しました #{e.message}"
        render "new"
    end
  end

  def check_product_stocks
    @baskets.each do |basket|
      product = basket.product
      stocks = product.count - basket.count
      if  stocks < 0
        flash[:danger] = "#{product.name}の在庫が不足しています。"
        return false
      else
        Product.update(count: stocks)
        current_user.purchases.create(product_id: product.id,count: basket.count)
        create_notification(product.store.user, product, "", "purchase")
        create_notification(product.store.user, product, "", "sold") if count == 0
      end
    end
  end

end
