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
         @baskets.each do |basket|
           product = basket.product
           Product.update(count: @stocks)
           current_user.purchases.create(product_id: product.id,count: basket.count)

           message = {"type": "text", "text": "#{current_user.name}さんが#{product.name}を購入しました。"}
           create_notification(product.store.user, product, "", "purchase") and (client.push_message(product.store.user.line_id, message) if product.store.user.line_id)

           message = {"type": "text", "text": "#{product.name}の在庫が0になりました。\n 簡単メニューから変更するか直接サイトから在庫を変更してください。>>#{product_path(product)}"}
           create_notification(product.store.user, product, "", "sold") and client.push_message(product.store.user.line_id, message) if (product.store.user.line_id && count == 0)

           UserMailer.notice_purchase(current_user,product,(product.price*product.count)).deliver_now
        end
        redirect_to baskets_path

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
  end

  def check_product_stocks
    @baskets.each do |basket|
      product = basket.product
      @stocks = product.count - basket.count
      flash[:danger] = "#{product.name}の在庫が不足しています。" and return false if stocks < 0
    end
  end

end
