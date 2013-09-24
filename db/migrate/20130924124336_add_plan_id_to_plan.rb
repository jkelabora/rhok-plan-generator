class AddPlanIdToPlan < ActiveRecord::Migration
  def change
    # to allow plans to know which plan they were copied from
    add_column :plans, :plan_id, :integer
  end
end
