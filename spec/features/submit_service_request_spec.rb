require "rails_helper"

RSpec.feature "ServiceRequest", type: :feature do
  before do
    workdey_data = Seed.new
    workdey_data.create_all
  end

  let(:user) do
    create(:user)
  end
  let(:service) { create(:service) }

  context "User submits a service request" do
    scenario "with valid input" do
      visit signin_path
      log_in_with(user.email, user.password)
      submit_request(service.start_date.strftime("%d %B, %Y"),
                     service.end_date.strftime("%d %B, %Y"))
      expect(page).to have_content("Duration")
    end

    scenario "with invalid input" do
      visit signin_path
      log_in_with(user.email, user.password)
      submit_request("22 October, 2016", "23 October, 2016")
      expect(page).to have_content("prohibited this service request")
    end
  end
end
