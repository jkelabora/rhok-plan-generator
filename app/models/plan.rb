class Plan < ActiveRecord::Base
  attr_accessible :name, :postcode

  has_many :tasks

end
