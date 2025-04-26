require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { create(:user) }
  let(:assignee) { create(:user) }
  let(:valid_attributes) do
    {
      title: 'Complete project',
      description: 'Finish all pending tasks',
      user: user,
      assignee: assignee
    }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      task = Task.new(valid_attributes)
      expect(task).to be_valid
    end

    it 'requires a title' do
      task = Task.new(valid_attributes.merge(title: nil))
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'requires a user' do
      task = Task.new(valid_attributes.merge(user: nil))
      expect(task).not_to be_valid
      expect(task.errors[:user]).to include("must exist")
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      task = Task.create(valid_attributes)
      expect(task.user).to eq(user)
    end

    it 'belongs to an assignee' do
      task = Task.create(valid_attributes)
      expect(task.assignee).to eq(assignee)
    end

    it 'can be unassigned' do
      task = Task.create(valid_attributes.merge(assignee: nil))
      expect(task.assignee).to be_nil
    end
  end

  describe 'enums' do
    it 'has correct status values' do
      expect(Task.statuses).to eq({
        'todo' => 'todo',
        'in_progress' => 'in_progress',
        'done' => 'done'
      })
    end

    it 'has correct priority values' do
      expect(Task.priorities).to eq({
        'low' => 0,
        'medium' => 1,
        'high' => 2
      })
    end

    it 'defaults to todo status' do
      task = Task.new
      expect(task.status).to eq('todo')
    end

    it 'defaults to medium priority' do
      task = Task.new
      expect(task.priority).to eq('medium')
    end
  end

  describe 'scopes' do
    let!(:todo_task) { create(:task, status: :todo, user: user) }
    let!(:in_progress_task) { create(:task, status: :in_progress, user: user) }

    it 'filters by status' do
      expect(Task.todo).to include(todo_task)
      expect(Task.todo).not_to include(in_progress_task)
    end
  end
end