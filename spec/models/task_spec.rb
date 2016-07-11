require "rails_helper"

RSpec.describe Task, type: :model do
  before :each do
    @user = create(:user, user_attr.merge(user_type: "taskee"))
    create(:user, user_attr.merge(user_type: "taskee"))
    @skillset = create(:skillset, user: @user)
  end

  describe ".current_user_city_street" do
    context "should set the user address given the right user email" do
      it do
        expect(Task.current_user_city_street(@user.email)).
          to eq "%#{@user.street_address}%"
      end
    end
  end

  describe ".get_taskees_nearby" do
    let(:taskee) { User.all }

    it "should return two taskees that match the exact city and street " do
      expect(Task.get_taskees_nearby(
        taskee,
        @user.street_address.downcase,
        @user.city.downcase
      ).count).to eq 1
    end
  end

  describe ".assign_task" do
    before(:each) do
      @task = create(:task, task_attr)
    end
    context "when skillsets is supplied" do
      it "adds skillset to the task" do
        Task.assign_task(@user.id, @task.id, @skillset.name)
        expect(@task.skillsets.first.name).to eq @skillset.name
      end
    end

    context "when skillsets is nil" do
      it "adds taskee id to the task" do
        Task.assign_task(@user.id, @task.id, nil)
        expect(Task.last.taskee_id).to eq @user.id
      end
    end
  end

  describe "#add_skillsets_to_task" do
    it "adds skillsets to the tasks_skillsets table" do
      task = create(:task, task_attr)
      task.add_skillsets_to_task(@skillset)
      expect(task.skillsets.first.name).to eq @skillset.name
    end
  end

  describe ".get_taskees" do
    context "return nil when the wrong keyword is passed" do
      it { expect(Task.get_taskees("Marketting", @user.email)).to eq nil }
    end
    context "returns an array of taskees nearby with the correct Keyword" do
      it { expect(Task.get_taskees(@skillset.name, @user.email).count).to eq 1 }
    end
  end
end
