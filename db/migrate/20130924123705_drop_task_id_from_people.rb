class DropTaskIdFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :task_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
