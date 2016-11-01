require "rails_helper"

RSpec.feature "PendingRequest", type: :feature do
  before do
    workdey_data = Seed.new
    workdey_data.create_all
  end

  let(:user) do
    create(:user)
  end
  let(:service) { create(:service) }

  scenario "User views pending requests list" do
    visit signin_path
    log_in_with(user.email, user.password)
    submit_request(service.start_date.strftime("%d %B, %Y"),
                   service.end_date.strftime("%d %B, %Y"))
    click_link "Pending Requests"
    expect(page).to have_selector(:xpath, "/html/body/div[1]/div"\
                                  "/table/tbody/tr/td[5]")
    service_title = find_all("tr td")[0].text
    find_all("td a.btn")[0].click
    expect(page).to have_content(service_title)
  end
end
