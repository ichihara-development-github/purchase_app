class UserMailer < ApplicationMailer

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードリセット"
  end

  def notice_purchase(product,total)
    @user = current_user
    @product = product
    @total = total
    mail to: user.email, subject: "購入完了通知"
  end

  def notice_sold(user,product, total)
    @user = current_user
    @product = product
    @total = total
    mail to: user.email, subject: "購入通知"
  end

end
