class Task < ActiveRecord::Base
  attr_accessible :name, :custom, :people, :id, :event_id, :tag_list, :guid, :task_id

  acts_as_taggable

  belongs_to :event

  has_many :allocations

  has_many :people, :through => :allocations

  before_create :init_guid

  # manage the self-referential nature of tasks
  has_many   :copied_tasks, :class_name => "Task", :foreign_key => "task_id"
  belongs_to :parent_task, :class_name => "Task", :foreign_key => "task_id"

  protected

  def init_guid
    self.guid = SecureRandom.hex
  end

end
