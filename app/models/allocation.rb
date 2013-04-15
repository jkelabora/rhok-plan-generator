class Allocation < ActiveRecord::Base
  attr_accessible :person_id, :task_id

  belongs_to :task
  belongs_to :person
end