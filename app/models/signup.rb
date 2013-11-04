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
  attribute :opt_out, Boolean

  # survey style questions
  attribute :alone, Boolean
  attribute :pets, Boolean

  validates :plan_name, presence: true
  validates :postcode, presence: true
  validates_numericality_of :postcode

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

  def persist!
    ActiveRecord::Base.transaction do
      if name.empty? and email.empty? and mobile.empty?
        @person = Person.anon
      else
        @person = Person.new(name: name, email: email, mobile: mobile)
      end
      @person.save

      # https://github.com/mbleigh/acts-as-taggable-on
      tasks = Task.tagged_with(tag_list, :any => true).where(custom: false)
      tasks.each do |original|
        duplicate = original.dup
        duplicate.custom = true

        if duplicate.save
          Allocation.create!(person_id: @person.id, task_id: duplicate.id)
        end
      end

      @plan = Plan.new(name: plan_name, postcode: postcode, opt_out: opt_out)
      @plan.save

      @plan.people << @person
    end

  end

  def tag_list
    arr = ["general"]
    arr << "alone" if alone
    arr << "pets" if pets
    puts arr
    arr
  end

end