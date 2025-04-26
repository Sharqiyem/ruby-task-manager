require 'rails_helper'

RSpec.feature 'Tasks', type: :feature do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  before { sign_in user }

  scenario 'User creates a new task' do
    visit new_task_path
    
    fill_in 'Title', with: 'New Task'
    select 'high', from: 'Priority'
    click_button 'Create Task'

    expect(page).to have_content('Task was successfully created')
    expect(Task.last.priority).to eq('high')
  end

  scenario 'User cannot edit others tasks' do
    other_task = create(:task, user: create(:user))
    visit edit_task_path(other_task)
    expect(current_path).to eq(tasks_path)
    expect(page).to have_content('Not authorized')
  end
end