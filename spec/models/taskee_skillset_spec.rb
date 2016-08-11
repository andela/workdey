require "rails_helper"

RSpec.describe TaskeeSkillset, type: :model do
  it { is_expected.to belong_to(:taskee).class_name("User") }
  it { is_expected.to belong_to(:skillset) }
end
