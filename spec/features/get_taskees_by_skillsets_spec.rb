require 'rails_helper'

RSpec.feature "GetTaskeesBySkillsets", type: :feature do
  let(:tasker) { create :user }
  let(:taskee) { create :user, user_type: "taskee" }
  let(:other_taskee) { create :user, user_type: "taskee" }
  let(:skillset) { create :skillset, user: taskee }

  feature "search taskees by skillsets" do
    scenario "tasker searches with skillsets that have taskers" do
      log_in_with tasker.email, tasker.password
      within "li.#search-input" do
        fill_in "my-search-field", with: skillset.name
end
