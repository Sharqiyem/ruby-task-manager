# Given("I am logged in as {string} with password {string}") do |email, password|
#   user = User.find_or_create_by!(email: email) do |u|
#     u.password = password
#   end
#   visit new_user_session_path
#   fill_in "Email", with: email
#   fill_in "Password", with: password
#   click_button "Log in"
# end


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