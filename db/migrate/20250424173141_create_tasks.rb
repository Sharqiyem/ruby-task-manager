class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.string :status
      t.references :assignee, null: true, foreign_key: { to_table: :users }  # Updated this line
      t.timestamps
    end
  end
end