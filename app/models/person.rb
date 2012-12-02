class Person < ActiveRecord::Base
  attr_accessible :name, :number, :email, :id, :task_id

  belongs_to :task

end
