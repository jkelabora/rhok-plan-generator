class Person < ActiveRecord::Base
  attr_accessible :name, :mobile, :email, :task_id

  belongs_to :task

end
