# features/step_definitions/auth_steps.rb

# Generic steps
Given("I am not signed in") do
  visit destroy_user_session_path if page.has_link?("Sign Out") || page.has_button?("Sign Out") # Handle case where user is already signed in
end

Given(/^I am logged in as "([^"]*)" with password "([^"]*)"$/) do |email, password|
  user = User.find_or_create_by(email: email) # Find or create the user
  user.password = password
  user.password_confirmation = password
  user.save! # Ensure the user is saved

  visit new_user_session_path
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Log in" # Or whatever your button text is
  # Optional: Add an assertion to check that the login was successful
  expect(page).to have_content("Signed in successfully.") # or similar message
end

# Login-specific steps
Then("I should be redirected to the login page") do
  expect(page).to have_current_path('/users/sign_in')
end

Then("I should be redirected to the sign-in page") do
  expect(current_path).to eq new_user_session_path
end



# Dashboard steps
When("I visit the dashboard page") do
  visit dashboard_path
end

Then("I should be redirected to the sign-in page") do
  expect(current_path).to eq new_user_session_path
end
# Login form steps
Given("I am on the login page") do
  visit '/users/sign_in'
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I click the navbar new task link") do
      find("a.nav-link", text: "New Task").click
end

When(/^I click the first button with text "([^"]*)"$/) do |button_text|
  first(".btn", text: button_text).click
end

When("I click {string} for {string}") do |action, task_title|
  # Find the row/element containing the task and click the action link/button
  # This might need specific selectors based on your HTML structure
  within(:xpath, "//*[contains(text(),'#{task_title}')]/ancestor::tr") do # Example XPath
     click_link_or_button action
   end
end

Then("I should not see {string}") do |text|
  expect(page).to have_no_content(text)
end

When(/^I click "(.*?)"$/) do |element_text| # handles links and buttons
  element_text = element_text.strip
  begin
    click_button element_text
  rescue Capybara::ElementNotFound
    click_link element_text
  end
end

Then("I should be on the sign-in page") do
  expect(current_path).to eq new_user_session_path # Use Devise helper or exact path
end

Then(/^I should see the "([^"]*)" in the alert$/) do |message|  # More specific
  within('.alert') { expect(page).to have_content(message) }
end



Then("I should see {string}") do |message|
  expect(page).to have_content(message) # Ensure the message is visible on the page
end
