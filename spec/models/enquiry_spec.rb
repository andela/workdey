require "rails_helper"

RSpec.describe Enquiry, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:notifications) }
  it { should validate_presence_of(:question) }

  let(:user) { create(:user, confirmed: true) }

  let(:admin) { create(:user, confirmed: true)}

end
