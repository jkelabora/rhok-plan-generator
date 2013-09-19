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
        candidate_postcodes.collect do |postcode|
          { name: postcode,
            postcode_node: true,
            children:
              all.select{|p| p.postcode == postcode && p.public? }.collect do |p|
                { name: p.name,
                  size: 7,
                  children: [{name: 'view', guid: p.public_guid}]
                }
              end + private_arr(all.select{|p| p.postcode == postcode && p.private? })
          }
        end
      }.to_json
  end

  private

  def all
    @all ||= Plan.all
  end

  def candidate_postcodes
    @pc ||= all.collect(&:postcode).uniq
  end

  def private_arr plans
    arr = []; plans.count.times{ arr << {name: 'private'} }; arr
  end

end