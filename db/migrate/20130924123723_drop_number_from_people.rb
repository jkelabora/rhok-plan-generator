class DropNumberFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :number
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
