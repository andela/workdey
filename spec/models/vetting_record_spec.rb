require 'rails_helper'

RSpec.describe VettingRecord, type: :model do
  it { should validate_presence_of(:confidence) }
  it { should validate_presence_of(:skill_proficiency) }
  it { should validate_presence_of(:experience) }
end
