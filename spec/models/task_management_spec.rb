require "rails_helper"

RSpec.describe TaskManagement, type: :model do
  let(:task_management) { TaskManagement.new }

  before :each do
    task_management.task_id = 1
    task_management.tasker_id = 1
    task_management.artisan_id = 1
    task_management.start_time = Time.now
    task_management.end_time = 2.hours.from_now
    task_management.description = "Run tests"
    task_management.amount = 3000
  end

  it { is_expected.to belong_to(:artisan).class_name("User") }
  it { is_expected.to belong_to(:tasker).class_name("User") }
  it { is_expected.to belong_to(:task) }

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

  describe ".validate_tasker_id" do
    it "must have a tasker-id" do
      task_management.tasker_id = nil
      expect(task_management.save).to be false
    end
  end

  describe ".validate_artisan_id" do
    it "must have a artisan id" do
      task_management.artisan_id = nil
      expect(task_management.save).to be false
    end
  end

  describe ".validate_start_time" do
    it "must have a start time" do
      task_management.start_time = nil
      expect(task_management.save).to be false
    end
  end

  describe ".validate_end_time" do
    it "should have an end time" do
      task_management.end_time = nil
      expect(task_management.save).to be false
    end
    it "has to be a valid end time" do
      task_management.end_time = Time.now - 2.hours
      expect(task_management.save).to be false
    end
  end

  describe ".validate_description" do
    it "must have a task description" do
      task_management.description = nil
      expect(task_management.save).to be false
    end
  end
end
