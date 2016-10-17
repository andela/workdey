require "rails_helper"

RSpec.describe ArtisanSkillset, type: :model do
  it { is_expected.to belong_to(:artisan).class_name("User") }
  it { is_expected.to belong_to(:skillset) }
end
