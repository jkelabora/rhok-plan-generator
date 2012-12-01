class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans do |t|
      t.string :name
      t.string :postcode
      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end
