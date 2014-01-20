class AddExplicitPublicPlanFlag < ActiveRecord::Migration
  def change
    add_column :plans, :is_public, :boolean, default: false
  end
end
