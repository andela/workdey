require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  subject(:user) do
    User.create do |user|
      user.firstname = "Ade"
      user.lastname = "Kunle"
      user.email = "ade@mail.com"
      user.password = "123456789"
    end
  end

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Account Activation")
      expect(mail.to).to eq(["ade@mail.com"])
      expect(mail.from).to eq(["noreply@workdey.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end