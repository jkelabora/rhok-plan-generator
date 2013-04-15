class AddPlanIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :plan_id, :integer
  end
end
