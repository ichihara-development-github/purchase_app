class ApplicationMailer < ActionMailer::Base
  default from: 'ichihara-purchase-app <no-replay@ichihara-purchase-app.com>', charset: 'ISO-2022-JP'
  layout 'mailer'
end
