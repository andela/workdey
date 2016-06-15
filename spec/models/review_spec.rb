require "rails_helper"

RSpec.describe Review, type: :model do
  it "" do
    is_expected.to belong_to(:reviewer).class_name("User").
    with_foreign_key(:reviewer_id)
  end

  it "" do
    is_expected.to belong_to(:reviewee).class_name("User").
    with_foreign_key(:reviewee_id)
  end

  it { is_expected.to belong_to(:task_management) }

  it { is_expected.to have_many(:review_comments) }
end
