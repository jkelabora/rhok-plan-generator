class Plan < ActiveRecord::Base
  attr_accessible :name, :postcode, :public_guid, :private_guid, :opt_out

  has_many :tasks
  has_many :people

  before_create :init_guids

  def opt_out
    @opt_out
  end

  def opt_out= transient_check_box_flag
    @opt_out = transient_check_box_flag
  end

  protected
    def init_guids
      self.private_guid = SecureRandom.hex 32
      self.public_guid = SecureRandom.hex 32 unless self.opt_out == '1'
    end

end
