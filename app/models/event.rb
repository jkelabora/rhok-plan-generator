class Event < ActiveRecord::Base
  attr_accessible :name, :priority, :tasks, :id

  has_many :tasks

end
