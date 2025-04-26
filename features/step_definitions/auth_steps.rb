# features/step_definitions/auth_steps.rb

# Generic steps
Given("I am not logged in") do
  visit '/users/sign_out'
end

Given(/^I am logged in as "([^"]*)" with password "([^"]*)"$/) do |email, password|
  user = User.find_or_create_by!(email: email) do |u|
    u.password = password
    u.password_confirmation = password
  end
  login_as(user, scope: :user)
  visit root_path
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end

# Login-specific steps
Then("I should be redirected to the login page") do
  expect(page).to have_current_path('/users/sign_in')
end

# Dashboard steps
When("I visit the dashboard page") do
  visit '/dashboard'
end

# Login form steps
Given("I am on the login page") do
  visit '/users/sign_in'
end

When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I click {string}") do |button_text|
  click_button button_text
end