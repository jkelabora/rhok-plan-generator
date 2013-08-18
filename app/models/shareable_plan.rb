class ShareablePlan < ActiveRecord::Base

  belongs_to :plan, :autosave => false, :dependent => :destroy

  attr_accessible :type, :plan, :guid

  before_create :init

  protected
    def init
        self.guid ||= SecureRandom.hex 32
    end
end
