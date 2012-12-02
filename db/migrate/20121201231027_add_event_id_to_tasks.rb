class AddEventIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :event_id, :integer
  end
end
