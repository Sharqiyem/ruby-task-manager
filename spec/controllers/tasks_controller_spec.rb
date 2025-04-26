require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:valid_attributes) { attributes_for(:task, user_id: user.id) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'only shows current user tasks' do
      task = create(:task, user: user)
      create(:task, user: other_user)
      get :index
      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Task' do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it 'assigns the current user as owner' do
        post :create, params: { task: valid_attributes }
        expect(Task.last.user).to eq(user)
      end
    end
  end

  describe 'PUT #update' do
    let!(:task) { create(:task, user: user) }

    it 'updates the task' do
      put :update, params: { id: task.id, task: { title: 'New title' } }
      task.reload
      expect(task.title).to eq('New title')
    end

    it 'prevents updating other users tasks' do
      other_task = create(:task, user: other_user)
      put :update, params: { id: other_task.id, task: { title: 'Hacked' } }
      expect(response).to redirect_to(tasks_path)
      expect(other_task.reload.title).not_to eq('Hacked')
    end
  end
end