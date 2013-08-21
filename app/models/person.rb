class Person < ActiveRecord::Base
  attr_accessible :name, :mobile, :email, :number

  has_many :allocations

  has_many :tasks, :through => :allocations

  def self.create_multiple params

    can_save = true

    p_names = params['p_names']
    p_emails = params['p_emails']
    p_mobiles = params['p_mobiles']

    (0..3).each do |i|
      unless p_names[i].blank?
        can_save &&= Person.new(name: p_names[i],
                               email:  p_emails[i],
                               mobile: p_mobiles[i]).save
      end
    end

    can_save

  end

end
