class CreateAllocations < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.column 'task_id', :integer
      t.column 'person_id',  :integer
      t.timestamps
    end
  end
end
