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
                  postcode_level_nodes(postcode)
              }
            end
        }.to_json
      end

      private

      def postcode_level_nodes postcode
        top_level_plans = Plan.top_level.for_postcode(postcode)
        public_and_private_nodes(top_level_plans)
      end

      def public_and_private_nodes plans
        public_nodes(plans) + private_node(plans)
      end

      def public_nodes plans
        plans.select{|p| p.is_public? }.collect do |p|
          {
            name: p.display_name,
            size: 4,
            children:
              view_node(p) + public_and_private_nodes(p.child_plans) #recurse
          }
        end
      end

      def private_node plans
        plan_count = plans.select{|p| !p.is_public? }.count
        return [] unless plan_count > 0
        [{
          name: "#{plan_count} private plan#{'s' if plan_count > 1}",
          size: plan_count
        }]
      end

      def view_node plan
        [{ size: 9, name: 'view!', guid: plan.public_guid, view_node: true }]
      end

    end

  end

end
