# frozen_string_literal: true
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

  describe ".get_taskees" do
    context "return nil when the wrong keyword is passed" do
      it { expect(Task.get_taskees("Marketting", @user.email)).to eq nil }
    end
    context "returns an array of taskees nearby with the correct Keyword" do
      it { expect(Task.get_taskees(@skillset.name, @user.email).count).to eq 1 }
    end
  end

  describe ".search_for_available_need" do
    let(:skillset) { create(:skillset) }
    let(:skillset2) { create(:skillset) }
    let!(:task1) { create(:task, task_attr.merge(skillset_id: skillset.id)) }
    let!(:task2) do
      create(:task,
             task_attr.merge(
               skillset_id: skillset.id,
               start_date: Date.yesterday
             ))
    end

    context "when searching for a need that has a task" do
      it "returns an array containing  the number of available task" do
        expect(Task.search_for_available_need(skillset.name).count).to eq 1
      end

      it "doesn't return tasks that the start date is in the past" do
        expect(
          Task.search_for_available_need(skillset.name)
        ).not_to include task2
      end
    end

    context "when searching for a need that has no task" do
      it "returns an empty array " do
        expect(Task.search_for_available_need(skillset2.name)).to eq []
      end
    end
  end
end
