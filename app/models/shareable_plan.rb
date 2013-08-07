class ShareablePlan < ActiveRecord::Base

  self.table_name = 'shareable_plans'

  belongs_to :plan, :autosave => false, :dependent => :destroy

  attr_reader :guid
  attr_accessible :type, :plan

  before_create :init

  protected
    def init
        self.guid ||= SecureRandom.hex 32
    end
end
