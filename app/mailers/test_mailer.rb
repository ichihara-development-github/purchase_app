class TestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.test.subject
  #
  def test
    @greeting = "Hi"

    mail to: "pasocon.cloud@icloud.com"
  end
end
