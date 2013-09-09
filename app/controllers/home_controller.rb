class HomeController < ApplicationController

  respond_to :json

  def index
    @postcode = params[:postcode]

    @public_plans = Plan.public_plans
    private_plans = Plan.private_plans
    if @postcode
      @public_plans = @public_plans.where(postcode: @postcode)
      private_plans = private_plans.where(postcode: @postcode)
    end

    @private_plan_count = private_plans.count
    @task_count = Task.count
    @allocation_count = Allocation.count
    @people_count = Person.count

    @blank_plan = Plan.new
  end

  def visualisation
    postcode = params[:postcode]
    @public_plans = Plan.public_plans
    @private_plans = Plan.private_plans
    unless postcode.empty?
      @public_plans = @public_plans.where(postcode: postcode)
      @private_plans = @private_plans.where(postcode: postcode)
    end

    arr = []; @private_plans.count.times{ arr << {name: 'private'} }

    render :json => {
      name: postcode.empty? ? 'all' : postcode, root_node: true,
      children:
        @public_plans.collect{|p|
          { name: p.name,
            size: 7,
            children: [{name: 'view', private_guid: p.private_guid}, {name: 'copy!', guid: p.public_guid}]
          }
        } + arr
    }.to_json

  end

end