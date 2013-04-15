class Plan < ActiveRecord::Base
  attr_accessible :name, :postcode

  has_many :tasks
  has_many :people

end
