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
          name: "#{Plan.count} plans!",
          root_node: true,
          children:
            Plan.uniq.pluck(:postcode).collect do |postcode|
              { name: postcode,
                postcode_node: true,
                children:
                  Plan.top_level.for_postcode(postcode).collect do |p|
                    generate_decendents(p)
                end
              }
            end
        }.to_json
      end

      private

      def generate_decendents node
        {
          name: node.display_name,
          size: 7
        }.merge(children(node))
      end

      def children node
        if node.private?
          {}
        else
          { children:
            node.child_plans.collect do |c|
              generate_decendents(c) # recurse
            end + [{ name: 'view!', guid: node.public_guid, view_node: true }]
          }
        end
      end

    end

  end

end