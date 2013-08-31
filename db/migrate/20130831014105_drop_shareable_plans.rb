class DropShareablePlans < ActiveRecord::Migration
  def up
    drop_table :shareable_plans
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
