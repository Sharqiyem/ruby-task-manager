class AddAssigneeToTasks < ActiveRecord::Migration[7.0]
  def change
    # Remove existing foreign key if it exists
    if foreign_key_exists?(:tasks, column: :assignee_id)
      remove_foreign_key :tasks, column: :assignee_id
    end

    # Add proper foreign key
    add_foreign_key :tasks, :users, column: :assignee_id
  end
end