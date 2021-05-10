# Preview all emails at http://localhost:3000/rails/mailers/test
class TestPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/test/test
  def test
    TestMailer.test
  end

end
