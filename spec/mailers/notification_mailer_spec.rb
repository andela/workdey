# frozen_string_literal: true
require "rails_helper"
RSpec.describe NotificationMailer, type: :mailer do
  before do
    workdey_data = Seed.new
    workdey_data.create_all
  end
  describe "send_notifications" do
    before(:each) do
      @user = create(:user, user_attr.merge(user_type: "artisan"))
      @skillset = create(:skillset)
      @tasker = create(:user, user_attr.merge(user_type: "tasker"))
      @artisan = create(:user, user_attr.merge(user_type: "artisan"))
      @task = create(
        :task,
        skillset_id: @skillset.id,
        tasker_id: @tasker.id,
        price_range: [
          Faker::Commerce.price(2000..3000).to_s,
          Faker::Commerce.price(3001..5000).to_s
        ]
      )
      @category = create(
        :task,
        skillset_id: @skillset.id,
        tasker_id: @tasker.id,
        price_range: [
          Faker::Commerce.price(2000..3000).to_s,
          Faker::Commerce.price(3001..5000).to_s
        ]
      )
      @mail = NotificationMailer.send_notifications(
        @user,
        @task,
        @category,
        @artisan,
        @tasker
      )
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("You have notifications on Workdey")
      expect(@mail.to).to eq([@artisan.email.to_s])
      expect(@mail.from).to eq(["noreply@workdey.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("Hi")
    end
  end

  describe "send_contact_info" do
    let(:artisan) do
      create(:user, user_type: "artisan", phone: Faker::PhoneNumber.cell_phone)
    end
    let(:tasker) { create(:user) }
    let(:mail) do
      NotificationMailer.send_contact_info(tasker, artisan).deliver_now
    end

    it "renders the subject" do
      expect(mail.subject).to eq(
        "#{artisan.fullname} has shared contact with you"
      )
    end

    it "sends to the tasker" do
      expect(mail.to).to eq [tasker.email]
    end
  end
end
