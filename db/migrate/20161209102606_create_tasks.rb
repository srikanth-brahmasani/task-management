class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :description
      t.integer :priority
      t.datetime :deadline
      t.date :reminder
      t.boolean :is_archieved
      t.boolean :is_done

      t.timestamps
    end
  end
end
