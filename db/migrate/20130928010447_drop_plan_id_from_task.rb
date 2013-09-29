class DropPlanIdFromTask < ActiveRecord::Migration
  def up
    remove_column :tasks, :plan_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
