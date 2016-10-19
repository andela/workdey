require "rails_helper"

RSpec.feature "Update Artisan Skill Set" do
  let!(:skillsets) { create_list(:skillset, 4) }
  let(:user) { create(:user, user_type: "artisan", confirmed: true) }
  let!(:artisan_skillset) do
    create(:artisan_skillset, artisan: user, skillset: skillsets.first)
  end

  before { log_in_with(user.email, user.password) }

  scenario "clicks 'My Skillset' link" do
    visit my_skillsets_path

    expect(page).
      to have_selector("li.collection-item", text: skillsets.first.name)
  end

  scenario "updates skill", js: true do
    visit "/my_skillsets"
    toggle_id = "div#" + skillsets.last.name.to_s
    within(toggle_id) { find("span.lever").click }
    click_button "Update My Skill Set"
    expect(page).to have_content("Skills updated successfully")
  end

  scenario "deactivates all skills", js: true do
    visit "/my_skillsets"
    toggle_id = "div#" + user.skillsets.first.name
    within(toggle_id) { find("span.lever").click }
    click_button "Update My Skill Set"
    expect(page).to have_content("Please choose at least one skill.")
  end
end
