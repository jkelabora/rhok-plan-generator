class HomeController < ApplicationController

  def index
    # postcode is provided in params but we'll hard-code to use 3113 for now
    @private_plan_count = Plan.where('public_guid is null').count
    @public_plans = Plan.where('public_guid is not null')
    @task_count = Task.count
    @allocation_count = Allocation.count
    @people_count = Person.count

    @blank_plan = Plan.new
  end

end