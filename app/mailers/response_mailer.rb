class ResponseMailer < ActionMailer::Base
  default from: "from@example.com"

  def email_digest(text)
  end
end
