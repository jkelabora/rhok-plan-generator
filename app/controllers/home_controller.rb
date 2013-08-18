class HomeController < ApplicationController

  def index
    # postcode is provided in params but we'll hard-code to use 3113 for now
    @plan_count = Plan.count
    @public_plans = Plan.where('public_guid is not null')
    @plan = Plan.first
    @task_count = Task.count
    @allocation_count = Allocation.count
    @people_count = Person.count
  end

end