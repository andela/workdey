require "rails_helper"

RSpec.describe TaskeeSkillset, type: :model do
  it { should belong_to(:skillset) }
  it { should belong_to(:taskee).class_name("User") }
end
