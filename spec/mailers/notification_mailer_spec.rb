require "rails_helper"
RSpec.describe NotificationMailer, type: :mailer do
  before do
    workdey_data = Seed.new
    workdey_data.create_all
  end
  describe "send_notifications" do
    before(:each) do
      @user = create(:user, user_attr.merge(user_type: "taskee"))
      @task = create(:task, task_attr)
      @category = create(:task, task_attr)
      @tasker = create(:user, user_attr.merge(user_type: "tasker"))
      @taskee = create(:user, user_attr.merge(user_type: "taskee"))
      @mail = NotificationMailer.send_notifications(
        @user,
        @task,
        @category,
        @taskee,
        @tasker
      )
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("You have notifications on Workdey")
      expect(@mail.to).to eq([@taskee.email.to_s])
      expect(@mail.from).to eq(["noreply@workdey.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("Hi")
    end
  end
end
