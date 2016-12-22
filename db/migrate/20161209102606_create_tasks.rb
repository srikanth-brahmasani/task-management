class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :description
      t.integer :priority
      t.datetime :deadline
      t.date :reminder
      t.boolean :is_archieved, default: false
      t.boolean :is_done, default: false

      t.timestamps
    end
  end
end
