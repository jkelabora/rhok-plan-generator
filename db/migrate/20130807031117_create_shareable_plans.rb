class CreateShareablePlans < ActiveRecord::Migration
  def change
    create_table :shareable_plans do |t|
      t.references :plan
      t.string :guid
      t.string :type

      t.timestamps
    end
    add_index :shareable_plans, :plan_id
  end
end
