class HomeController < ApplicationController

  respond_to :json

  def index
    @people_count = Person.count
    @task_count = Task.count
    @allocation_count = Allocation.count
    @blank_plan = Plan.new
  end

  def visualisation
    render :json => {
      name: "#{Plan.count} plans!", root_node: true,
      children:
        Plan.all.collect(&:postcode).uniq.collect do |postcode|
          { name: postcode,
            postcode_node: true,
            children:
              Plan.public_plans.where(postcode: postcode).collect do |p|
                { name: p.name,
                  size: 7,
                  children: [{name: 'view', private_guid: p.private_guid}, {name: 'copy!', guid: p.public_guid}]
                }
              end + private_arr(Plan.private_plans.where(postcode: postcode))
          }
        end
      }.to_json
  end

  private

  def private_arr plans
    arr = []; plans.count.times{ arr << {name: 'private'} }; arr
  end

end