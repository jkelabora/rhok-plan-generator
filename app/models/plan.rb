class Plan < ActiveRecord::Base
  attr_accessible :name, :postcode, :public_guid, :private_guid, :is_public, :plan_id

  validates_uniqueness_of :private_guid
  validates_uniqueness_of :public_guid, if: Proc.new { |p| p.is_public? }
  validates_numericality_of :postcode
  validates_length_of :postcode, is: 4

  has_many :people

  # manage the self-referential nature of plans
  has_many   :child_plans, :class_name => "Plan", :foreign_key => "plan_id"
  belongs_to :parent_plan, :class_name => "Plan", :foreign_key => "plan_id"

  before_create :init_guids

  # using *_plan names for these so as not to clash with existing AR methods
  scope :public_plans,  -> { where( is_public: true  ) }
  scope :private_plans, -> { where( is_public: false ) }

  scope :top_level,     -> { where(plan_id: nil) }
  scope :for_postcode,  ->(postcode) { where(postcode: postcode) }

  def display_name
    if is_public?
      self.name
    else
      '(private plan)'
    end
  end

  def escaped_name
    require 'uri'
    URI.escape self.name
  end

  def duplicate
    @duplicate = Plan.new(name: "#{self.name}-COPY", postcode: self.postcode, plan_id: self.id, is_public: false)
    anon = Person.anon
    transaction do
      anon.save
      @duplicate.people << anon
      Event.all.each do |ev|
        self.people.each do |person|
          tasks = person.tasks.where(event_id: ev)
          tasks.each do |t|
            dup_task = t.dup
            dup_task.custom = true
            dup_task.save
            Allocation.create!(person_id: anon.id, task_id: dup_task.id)
          end
        end
      end # close transaction
    end
    @duplicate
  end

  protected
    def init_guids
      self.private_guid = SecureRandom.hex 4
      self.public_guid  = SecureRandom.hex 4
    end

end
