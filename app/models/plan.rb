class Plan < ActiveRecord::Base
  attr_accessible :name, :postcode, :public_guid, :private_guid, :opt_out, :latitude, :longitude, :gmaps

  validates_uniqueness_of :private_guid
  validates_uniqueness_of :public_guid, unless: Proc.new { |p| p.public_guid == nil || p.public_guid.empty? }

  has_many :tasks
  has_many :people

  before_create :init_guids

  # using *_plan names for these so as not to clash with existing AR methods
  scope :public_plans,  -> { where( "public_guid is not null and public_guid <> ''" ) }
  scope :private_plans, -> { where( :public_guid => [nil, ''] ) } # a way to get to a working OR clause

  acts_as_gmappable

  def gmaps4rails_address
    "#{self.postcode}, Australia"
    #"90 Water St, New York, NY 10005"
  end

  def opt_out
    @opt_out
  end

  def opt_out= transient_check_box_flag
    @opt_out = transient_check_box_flag
  end

  protected
    def init_guids
      self.private_guid = SecureRandom.hex 4
      self.public_guid = SecureRandom.hex 4 unless self.opt_out == '1'
    end

end
