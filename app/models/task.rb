class Task < ActiveRecord::Base
  attr_accessible :name, :compulsory, :people, :id, :event_id

  belongs_to :event

  belongs_to :plan

  has_many :allocations

  has_many :people, :through => :allocations

end
