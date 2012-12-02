class Task < ActiveRecord::Base
  attr_accessible :name, :compulsory, :people, :id, :event_id

  belongs_to :event

  has_many :people

end
