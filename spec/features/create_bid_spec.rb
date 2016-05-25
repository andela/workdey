require "rails_helper"

RSpec.feature "Create Task for bidding", type: :feature do
  before(:all) do
    Capybara.default_driver = :selenium
  end

  before(:each) do
    user_attr = {
      user_type: "tasker",
      has_taken_quiz: true,
      confirmed: true,
      phone: nil
    }
    @user = create(:user, user_attr)
    log_in_with(@user.email, @user.password)
  end

  scenario "tasker can see a link to the biddings page" do
    within("div.sidebar-dash") { expect(page).to have_content("Biddings") }
  end

  scenario "tasker can click on biddings link and be directed to biddings\
   page" do
    click_link "Biddings"
    expect(page).to have_selector("h1", "Bids")
    expect(page).to have_selector("a", "add")
  end

  scenario "tasker can click on add button and be redirected to an add bid\
   form" do
    click_link "Biddings"
    click_link "add"
    expect(page).to have_selector("h2", "New Bid")
    expect(page).to have_css("form.new_bidding")
  end

  scenario "tasker can add a new bid" do
    create_a_bid("House Cleaning", "I'd like my kitchen cleaned.", "2000")
    expect(current_path).to eq(biddings_path)
    expect(page).to have_content("House Cleaning")
  end

  scenario "tasker can edit a bid" do
    create(:bidding, tasker_id: @user.id)
    visit biddings_path
    click_link "Edit"
    fill_in "bidding_name", with: "Washing"
    click_button "Update Bidding"
    expect(page).to have_content("Washing")
  end

  scenario "tasker can delete a bid" do
    create(:bidding, tasker_id: @user.id)
    visit biddings_path
    click_link "delete"
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_no_content("Cleaning")
  end

  def create_a_bid(task_name, description, price_range)
    click_link "Biddings"
    click_link "add"
    fill_in "bidding_name", with: task_name
    fill_in "bidding_description", with: description
    fill_in "bidding_price_range", with: price_range
    click_button "Create Bidding"
  end
end
