class Signup
  
  # http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/

  include Virtus

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_reader :person
  attr_reader :plan

  attribute :plan_name, String
  attribute :postcode, String

  attribute :name, String
  attribute :email, String
  attribute :mobile, String

  # survey style questions
  attribute :alone, Boolean
  attribute :pets, Boolean

  validates :plan_name, presence: true
  validates :postcode, presence: true
  validates_numericality_of :postcode
  validates_length_of :postcode, is: 4

  # Forms are never themselves persisted
  def persisted?
    false
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def tag_list
    [ 'pets', 'not_pets', 'alone', 'not_alone', 'children', 'not_children' ]
  end

  def all_untagged_suggested_tasks
    Task.tagged_with(tag_list, :exclude => true).where(custom: false)
  end

  def persist!
    ActiveRecord::Base.transaction do
      @person = Person.anon
      @person.save

      # https://github.com/mbleigh/acts-as-taggable-on
      tasks = all_untagged_suggested_tasks
      tasks += Task.tagged_with('pets') if pets
      tasks += Task.tagged_with('not_pets') unless pets
      # there isn't an explicit question about children yet so !alone = children
      tasks += Task.tagged_with(['alone', 'not_children']) if alone
      tasks += Task.tagged_with(['not_alone', 'children']) unless alone

      tasks.each do |original|
        duplicate = original.dup
        duplicate.custom = true
        duplicate.parent_task = original

        if duplicate.save
          Allocation.create!(person_id: @person.id, task_id: duplicate.id)
        end
      end

      @plan = Plan.new(name: plan_name, postcode: postcode, is_public: false)
      @plan.save

      @plan.people << @person
    end

  end

end