require 'rails_helper'

RSpec.describe Rating, type: :model do
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:rating) }
  it { should belong_to(:user) }
end
