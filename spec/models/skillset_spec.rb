require "rails_helper"

RSpec.describe Skillset, type: :model do
  it do
    is_expected.to have_many(:artisans).class_name("User").
      through(:artisan_skillsets)
  end

  it { is_expected.to have_many(:tasks) }

  it do
    is_expected.to have_many(:artisan_skillsets).with_foreign_key(:skillset_id)
  end

  it { is_expected.to validate_presence_of(:name) }
end
