class Task < ApplicationRecord
   has_many :activity_logs, dependent: :destroy

  scope :filter_by_status, ->(status) { where(status: status) if status.present? }
  scope :filter_by_priority, ->(priority) { where(priority: priority) if priority.present? }
  
  # Ex:- scope :active, -> {where(:active => true)}
  belongs_to :user, optional: true  # Changed to optional for existing data
  belongs_to :assignee, class_name: "User", optional: true
    
  enum :status, { todo: "todo", in_progress: "in_progress", done: "done" }, default: :todo
  enum :priority, { low: 0, medium: 1, high: 2 }, default: :medium

  
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 1000 }
  validates :status, inclusion: { in: statuses.keys }
  validates :priority, inclusion: { in: priorities.keys }

  after_create :notify_assignee
  after_update :log_changes

  private
  def notify_assignee
    # Add notification logic here
  end

  def log_changes
    if saved_change_to_status?
      activity_logs.create(
        user: Current.user,
        action: 'status_change',
        old_value: status_before_last_save,
        new_value: status
      )
    end
  end
end