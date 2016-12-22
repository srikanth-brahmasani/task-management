class AddDefaultValueToIsDone < ActiveRecord::Migration
  def change
    change_column :tasks, :is_done, :boolean, :default => false
    change_column :tasks, :is_archieved, :boolean, :default => false

  end
end
