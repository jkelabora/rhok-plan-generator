class AddGuidToTasks < ActiveRecord::Migration
  
  def up
    add_column :tasks, :guid, :string

    tasks_that_need_updating = ActiveRecord::Base.connection.execute 'select id from tasks where guid is null'
    tasks_that_need_updating.each do |id|
      ActiveRecord::Base.connection.execute "update tasks set guid = '#{SecureRandom.hex}' where id = #{id[0]}"
    end

  end

  def down
    drop_column :tasks, :guid
  end

end
