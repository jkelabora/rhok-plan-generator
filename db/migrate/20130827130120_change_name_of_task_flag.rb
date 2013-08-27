class ChangeNameOfTaskFlag < ActiveRecord::Migration
  def change
    rename_column :tasks, :compulsory, :custom
    change_column :tasks, :custom, :boolean, :default => true
  end
end
