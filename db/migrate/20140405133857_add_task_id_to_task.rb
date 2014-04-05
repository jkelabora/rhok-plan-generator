class AddTaskIdToTask < ActiveRecord::Migration
  def change
    # to identify tasks that were copied from others
    add_column :tasks, :task_id, :integer
  end
end
