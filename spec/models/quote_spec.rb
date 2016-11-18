require 'rails_helper'

RSpec.describe Quote, type: :model do
  it { is_expected.to validate_presence_of :artisan_id }
  it { is_expected.to validate_presence_of :service_id }
  it { is_expected.to validate_presence_of :quoted_value }
  it { is_expected.to belong_to :artisan }
  it { is_expected.to belong_to :service }
  it { is_expected.to define_enum_for :status }
end
