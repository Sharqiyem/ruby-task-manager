class User < ApplicationRecord
  has_many :tasks, foreign_key: :user_id, dependent: :destroy
  has_many :assigned_tasks, class_name: "Task", foreign_key: :assignee_id
  
  belongs_to :team, optional: true
  # has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  def admin?
    admin == true
  end
end
