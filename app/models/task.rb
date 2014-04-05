class Task < ActiveRecord::Base
  attr_accessible :name, :custom, :people, :id, :event_id, :tag_list, :guid

  acts_as_taggable

  belongs_to :event

  has_many :allocations

  has_many :people, :through => :allocations

  before_create :init_guid

  protected

  def init_guid
    self.guid = SecureRandom.hex
  end

end
