class UserMailer < ApplicationMailer

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードリセット"
  end

  def notice_purchase(user,product,total)
    @user = user
    @product = product
    @total = total
    mail to: user.email, subject: "購入完了通知"
  end

end
