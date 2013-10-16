class Plan < ActiveRecord::Base
  attr_accessible :name, :postcode, :public_guid, :private_guid, :opt_out, :plan_id

  validates_uniqueness_of :private_guid
  validates_uniqueness_of :public_guid, unless: Proc.new { |p| p.public_guid == nil || p.public_guid.empty? }

  has_many :people

  # manage the self-referential nature of plans
  has_many   :child_plans, :class_name => "Plan", :foreign_key => "plan_id"
  belongs_to :parent_plan, :class_name => "Plan", :foreign_key => "plan_id"

  before_create :init_guids

  # using *_plan names for these so as not to clash with existing AR methods
  scope :public_plans,  -> { where( "public_guid is not null and public_guid <> ''" ) }
  scope :private_plans, -> { where( :public_guid => [nil, ''] ) } # a way to get to a working OR clause

  scope :top_level,     -> { where(plan_id: nil) }
  scope :for_postcode,  ->(postcode) { where(postcode: postcode) }

  def opt_out
    @opt_out
  end

  def opt_out= transient_check_box_flag
    @opt_out = transient_check_box_flag
  end

  def display_name
    if public?
      self.name
    else
      '(details withheld)'
    end
  end

  def public?
    !!self.public_guid
  end

  def private?
    !public?
  end

  def duplicate
    @duplicate = Plan.new(name: "#{self.name}-COPY", postcode: self.postcode, plan_id: self.id)
    anon = Person.anon
    transaction do
      anon.save
      @duplicate.people << anon
      Event.all.each do |ev|
        self.people.each do |person|
          tasks = person.tasks.where(event_id: ev)
          tasks.each do |t|
            dup_task = t.dup
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
      self.public_guid = SecureRandom.hex 4 unless self.opt_out
    end

end
