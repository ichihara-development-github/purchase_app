class ApplicationMailer < ActionMailer::Base
  default from: 'noreplay@ichihara-purchase-app.com', charset: 'ISO-2022-JP'
  layout 'mailer'
end
