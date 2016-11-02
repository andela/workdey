require "rails_helper"

RSpec.describe "Notification of artisans for new tasks", type: :feature do
  let!(:artisan) { create(:user, user_attr.merge(user_type: "artisan")) }
  let!(:tasker) { create(:user, user_attr.merge(user_type: "tasker")) }
  let!(:skillset) { create(:skillset) }
  let!(:service) do
    create(
      :service,
      skillset_id: skillset.id,
      tasker_id: tasker.id
    )
  end

  before(:each) do
    create(
      :notification,
      notifiable_id: service.id,
      receiver_id: artisan.id,
      sender_id: tasker.id,
      notifiable_type: "Service"
    )
    log_in_with artisan.email, artisan.password
    visit notifications_path
    page.all(".btn")[0].click
  end

  scenario "artisan rejects a task" do
    click_on "Reject"
    expect(page).to have_content "Task Rejected"
  end

  scenario "artisan accepts a task" do
    click_on "Accept"
    expect(page).to have_content "Name your price"
  end

  feature "User sends a quote" do
    scenario "User enters a Zero or negative quote" do
      click_on "Accept"
      fill_in "quote_value", with: -200
      click_on "send-quote"
      alert_text = page.driver.browser.switch_to.alert.text
      expect(alert_text).to eq "Quote value must be greater than 0"
    end

    scenario "User fails to give a quote" do
      click_on "Accept"
      click_on "send-quote"
      alert_text = page.driver.browser.switch_to.alert.text
      expect(alert_text).to eq "You must enter a quote."
    end

    # scenario "when a valid quote is entered" do
    #   click_on "Accept"
    #   fill_in "quote_value", with: 200
    #   click_on "send-quote"
    #   expect(page).to have_content("Task Accepted")
    # end
  end
end
