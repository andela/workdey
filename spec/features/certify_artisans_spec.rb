require "rails_helper"
RSpec.feature "Admin can rate artisans", type: :feature do
  background do
    workdey_data = Seed.new
    workdey_data.create_all
  end

  before(:each) do
    @user = create(:user, user_type: "admin")
    stub_current_user(@user)
    @uncertified_user = create(:user, status: "accepted")
    create(:vetting_record, user_id: @uncertified_user.id)
  end

  scenario "Admin sees a list of uncertified artisans" do
    visit admin_certify_artisans_path
    expect(page).to have_content("Uncertified Artisans")
    expect(page).to have_content(@uncertified_user.firstname)
  end

  scenario "Admin can see the vetting record of an uncertified artisan" do
    visit_new_rating_path
    expect(page).to have_content(@uncertified_user.firstname)
  end

  context "When all required fields are entered" do
    scenario "Admin submits the rating results" do
      visit_new_rating_path
      fill_in :rating["comment"], with: "a comment"
      find("#rating").click
      click_button "Submit"
      expect(page.current_path).to eq admin_certify_artisans_path
      expect(page).to have_no_content(@uncertified_user.firstname)
    end
  end

  context "When admin does not give a comment when rating" do
    scenario "Admin is prompted to enter a comment" do
      visit_new_rating_path
      find("#rating").click
      click_button "Submit"
      expect(page).to have_content("comment: can't be blank")
    end
  end

  context "When admin does not give a rating" do
    scenario "Admin is prompted to give a rating" do
      visit_new_rating_path
      fill_in :rating["comment"], with: "a comment"
      click_button "Submit"
      expect(page).to have_content("rating: can't be blank")
    end
  end

  def visit_new_rating_path
    visit "ratings/new/" + @uncertified_user.id.to_s
  end
end
