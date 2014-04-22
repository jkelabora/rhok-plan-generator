class HomeController < ApplicationController

  respond_to :json

  def index
    @people_count = Person.count
    @task_count = Task.count
    @allocation_count = Allocation.count
    @blank_plan = Plan.new
  end

  def visualisation
    render :json => VisualisationPresenter.present
  end

  private

  class VisualisationPresenter

    class << self

      def present
        {
          name: "#{Plan.count} plans across #{Plan.uniq.pluck(:postcode).count} postcodes!",
          root_node: true,
          size: Plan.count,
          children:
            Plan.uniq.pluck(:postcode).collect do |postcode|
              { name: "#{postcode}",
                postcode_node: true,
                size: Plan.for_postcode(postcode).count,
                children:
                  Plan.top_level.for_postcode(postcode).public_plans.collect do |p|
                    generate_decendents(p)
                  end + [{ size: Plan.top_level.for_postcode(postcode).private_plans.count, name: "#{Plan.top_level.for_postcode(postcode).private_plans.count} private plans!" }]
              }
            end
        }.to_json
      end

      private

      def generate_decendents node
        {
          name: node.display_name,
          size: 4,
        }.merge(children(node))
      end

      def children node
        { children:
          node.child_plans.collect do |c|
            generate_decendents(c) # recurse
          end + [{ size: 9, name: 'view!', guid: node.public_guid, view_node: true }]
        }
      end

    end

  end

end