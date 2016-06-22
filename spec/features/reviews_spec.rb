require "rails_helper"

RSpec.feature "Reviews", type: :feature do
  before :all do
    Capybara.default_driver = :selenium
  end
  before(:each) do
    @user = create(:user, confirmed: true)
    @user2 = create(:user, user_type: "taskee")
    @task = create(:task_management)
    @review = create(
      :review,
      reviewee_id: @user2.id,
      reviewer_id: @user.id,
      task_management_id: @task.id
    )
  end

  scenario "user can see links to reviews on his dashboard" do
    log_in_with @user.email, @user.password
    expect(page).to have_link "Reviews"
    expect(page).to have_link "Review a taskee"
  end

  scenario "user can see the list of reviews given" do
    log_in_with @user.email, @user.password
    click_on "Reviews"
    expect(page).to have_content "Reviews Given"
    expect(page).to have_content "Feedbacks Received"
    expect(page).to have_link @review.task_management
    expect(page).to have_content @user2.firstname_and_lastname
  end
end
