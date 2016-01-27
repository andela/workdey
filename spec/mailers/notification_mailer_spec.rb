require "rails_helper"

RSpec.describe NotificationMailer, type: :mailer do
  before do
    workdey_data = Seed.new
    workdey_data.create_all
  end
  describe "send_notifications" do
    let(:user) { User.first  }
    let(:task) { Task.last }
    let(:task_category) { Task.first }
    let(:notification_taskee) { User.first }
    let(:notification_tasker) { User.last }
    let(:mail) { NotificationMailer.send_notifications(user, task, task_category, notification_taskee, notification_tasker) }

    it "renders the headers" do
      expect(mail.subject).to eq("You have notifications on Workdey")
      expect(mail.to).to eq(["olaide.ojewale@andela.com"])
      expect(mail.from).to eq(["noreply@workdey.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end