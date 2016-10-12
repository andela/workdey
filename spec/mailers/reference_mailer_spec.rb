require "rails_helper"

RSpec.describe ReferenceMailer, type: :mailer do
  describe "reference_email" do
    let(:user) { create(:user) }
    let(:url) do
      "#{new_dashboard_endorsement_url}?t=#{reference.confirmation_token}"
    end
    let(:reference) { create(:reference, artisan_id: user.id) }
    let(:mail) { described_class.reference_email(reference, url).deliver_now }

    it "renders the subject" do
      expect(mail.subject).to eq("Reference Request")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([reference.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@workdey.com"])
    end

    it "assigns @reference" do
      expect(mail.body.encoded).to match(reference.firstname)
    end
  end
end
