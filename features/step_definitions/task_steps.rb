# Given("I am logged in as {string} with password {string}") do |email, password|
#   user = User.find_or_create_by!(email: email) do |u|
#     u.password = password
#   end
#   visit new_user_session_path
#   fill_in "Email", with: email
#   fill_in "Password", with: password
#   click_button "Log in"
# end

# require 'faker' # Add this if task factories use Faker

When("I visit the tasks page") do
  visit tasks_path # Ensure tasks_path is defined in routes.rb
end

When(/^I click the first button with text "([^"]*)"$/) do |button_text|
  # Use the :button selector type for better semantics
  first(:button, button_text).click
end

When("I select {string} from priority") do |priority_text|
  # Replace 'task_priority' with the actual ID or Name of your select box
  select(priority_text, from: 'task_priority')
end

Given("I have a task {string}") do |task_title|
  # Assuming you have a logged-in user stored in @user or similar
  # If not, you need to create one first or adjust the factory
  user = @current_user || FactoryBot.create(:user) # Get or create user
  FactoryBot.create(:task, title: task_title, user: user)
end

# --- Add other task-related steps here ---
# Example for Edit/Delete steps (You'll need to implement these)
When("I click {string} for {string}") do |action, task_title|
  # Find the row/element containing the task and click the action link/button
  # This might need specific selectors based on your HTML structure
  within(:xpath, "//*[contains(text(),'#{task_title}')]/ancestor::tr") do # Example XPath
     click_link_or_button action
   end
end

When("I confirm the deletion") do
  accept_alert # Assumes a standard browser confirmation dialog
end

Then("I should not see {string}") do |text|
  expect(page).to have_no_content(text)
end

When("I visit the tasks page") do
  visit tasks_path
end

When('I select {string} from priority') do |priority|
  select priority, from: 'Priority'
end

# Given("I have a task {string}") do |title|
#   user = User.last || create(:user)
#   Task.create!(title: title, user: user)
# end

Given('I have a task {string}') do |title|
  @task = create(:task, title: title, user: @current_user)
end

When('I drag {string} to the {string} column') do |task_title, column|
  # Implement drag and drop simulation
end