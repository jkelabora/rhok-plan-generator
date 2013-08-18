class Plan < ActiveRecord::Base
  attr_accessible :name, :postcode, :public_guid, :private_guid

  has_many :tasks
  has_many :people

  before_create :init

  protected
    def init
      self.private_guid ||= SecureRandom.hex 32
      self.public_guid  ||= SecureRandom.hex 32
    end

end
