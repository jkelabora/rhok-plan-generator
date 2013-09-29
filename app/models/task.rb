class Task < ActiveRecord::Base
  attr_accessible :name, :custom, :people, :id, :event_id

  belongs_to :event

  has_many :allocations

  has_many :people, :through => :allocations

end
