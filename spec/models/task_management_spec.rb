require "rails_helper"

RSpec.describe TaskManagement, type: :model do
  let(:task_management) { TaskManagement.new }

  before :each do
    task_management.task_id = 1
    task_management.tasker_id = 1
    task_management.taskee_id = 1
    task_management.start_time = Time.now
    task_management.end_time = 2.hours.from_now
    task_management.task_desc = "Run tests"
    task_management.amount = 3000
  end

  it { is_expected.to belong_to(:taskee).class_name("User") }
  it { is_expected.to belong_to(:tasker).class_name("User") }
  it { is_expected.to have_one(:task).with_foreign_key(:id) }

  describe ".validate_amount" do
    it "will fail if amount is not a number" do
      task_management.amount = "ABC"
      expect(task_management.save).to be false
    end

    it "will fail if it is absent" do
      task_management.amount = nil
      expect(task_management.save).to be false
    end
  end

  describe ".validate_task_id" do
    it "must have a task id" do
      task_management.task_id = nil
      expect(task_management.save).to be false
    end
  end
end