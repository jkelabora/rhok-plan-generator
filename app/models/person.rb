class Person < ActiveRecord::Base
  attr_accessible :name, :mobile, :email, :number

  has_many :allocations
  has_many :tasks, :through => :allocations

  def self.anon
    self.new(name: 'anonymous', email: '', mobile: '')
  end

end
