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

  validates :plan_name, presence: true
  validates :postcode, presence: true
  # … more validations …

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
    @plan = Plan.create!(name: plan_name, postcode: postcode, opt_out: opt_out)

    if name.empty? and email.empty? and mobile.empty?
      @person = Person.anon
    else
      @person = Person.new(name: name, email: email, mobile: mobile)
    end
    @plan.people << @person

  end
end