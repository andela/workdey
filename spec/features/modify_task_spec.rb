require "rails_helper"

RSpec.feature "Modify Task" do
  let(:skillset) { create(:skillset) }
  let(:user) { create(:user, user_attr.merge(user_type: "tasker")) }
  let!(:task) do
    create(
      :task,
      skillset_id: skillset.id,
      tasker_id: user.id,
      price_range: %w(2000 4000)
    )
  end

  before(:each) do
    log_in_with(user.email, user.password)
    visit my_tasks_path
  end

  scenario "user visits tasks page" do
    expect(page).to have_content("Task logs")
    expect(page).to have_css("a#edit_task_#{task.id}")
    expect(page).to have_css("a#delete_task_#{task.id}")
  end

  scenario "user clicks edit" do
    click_link "edit_task_#{task.id}"
    expect(page).to have_current_path edit_dashboard_task_path(task)
  end

  scenario "user edits task" do
    visit edit_dashboard_task_path(task)

    fill_in "task_description", with: "Lorem ipsum dolor sit amet," \
      " consectetur adipisicing elit."
    click_button "Update Task"

    expect(page).to have_current_path dashboard_task_path(task)
    expect(page).to have_content("Your task has been successfully updated")
  end

  scenario "user clicks delete" do
    click_link "delete_task_#{task.id}"
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_current_path my_tasks_path
    expect(page).not_to have_content task.name
  end
end
