class IncreaseTaskNameSize < ActiveRecord::Migration
  def up
    change_column :tasks, :name, :string, :limit => 1000
  end
  def down
    change_column :tasks, :name, :string, :limit => 255
  end
end
