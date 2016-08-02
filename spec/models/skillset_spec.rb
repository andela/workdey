# frozen_string_literal: true
require "rails_helper"

RSpec.describe Skillset, type: :model do
  it { should have_many(:tasks) }
  it do
    should have_many(:taskees).with_foreign_key("taskee_id").
      class_name("User").through(:taskee_skillsets)
  end
  it { should validate_presence_of(:name) }
end
