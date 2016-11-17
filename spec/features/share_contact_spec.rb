require "rails_helper"

RSpec.describe "Share contact", js: true do
  before do
    page.driver.browser.manage.window.maximize
  end
  let(:artisan) { create(:user, user_type: "artisan", confirmed: true) }
  let(:tasker) { create(:user, user_type: "tasker", confirmed: true) }
  let!(:task) do
    create(
      :task_management,
      artisan_id: artisan.id,
      tasker_id: tasker.id,
      paid: true,
      status: "active"
    )
  end

  before(:each) do
    log_in_with(artisan.email, artisan.password)
  end

  describe "artisan" do
    scenario "When artisan shares contact with tasker", js: true do
      share_contact

      expect(page).to have_content "Success!"
      expect(task.reload.shared).to be_truthy
    end

    scenario "When artisan doesn't share contact with tasker" do
      share_contact(false)

      expect(page).to have_content("You can share your contact later")
      expect(task.shared).to be_falsy
    end
  end

  describe "tasker" do
    scenario "when tasker views the artisan's quote " do
      Capybara.reset_sessions!
      send_quote
      log_in_with(tasker.email, tasker.password)
      visit notifications_path
      click_on "view quote"
      click_button "Accept"
      expect(page).to have_content(artisan.firstname)
      expect(page).to have_content(artisan.email)
    end
  end


  def share_contact(share = true)
    visit my_tasks_path
    click_on "Share Contact"
    sleep 1.5
    share ? click_on("Yes, share it") : click_on("No, don't share")
  end

  def send_quote
    quote = create(:quote, artisan_id: artisan.id)
    create(
      :notification,
      receiver_id: tasker.id,
      sender_id: artisan.id,
      notifiable_type: "Quote",
      notifiable_id: quote.id
    )
  end
end
