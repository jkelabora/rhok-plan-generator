
# find:    ^((?!event).*)\n
# replace: Task.find_or_create_by_custom_and_name_and_event_id(false, "$1", event.id)\n

class WhiteListedDataDestroyer

  def clear_out_all_plans_and_data_except_for_these_plans

    candidate_ids = Plan.pluck(:id) - yield
    Plan.find_all_by_id(candidate_ids).each do |plan|
        plan.people.each { |person|
            person.tasks.destroy_all
            person.allocations.destroy_all
            person.destroy
            plan.destroy
        }
    end

  end

end

class OnceOffTemplateLoad

    attr_reader :name, :postcode
    def initialize name, postcode
        @name = name
        @postcode = postcode
    end

  # designed to only persist data once (despite subsequent executions) to preserve updates via ActiveAdmin
    def load_template_plan

        return unless Plan.where(name: name, postcode: postcode).empty?

        require 'csv'
        Dir.glob(File.join(Rails.root,"fixtures/#{name_as_directory}/*")).each do |filename|

    end

    def events
        @events ||= []
    end

    def setup_events
        events << Event.find_or_create_by_name("Before the bushfire season")
        events << Event.find_or_create_by_name("On a high risk day")
        events << Event.find_or_create_by_name("Should leaving early be impossible")
        events << Event.find_or_create_by_name("If fire directly threatens the house")
        events << Event.find_or_create_by_name("When the fire front has passed")
        events << Event.find_or_create_by_name("Relocation Kit")
        events << Event.find_or_create_by_name("Emergency Kit")
        events << Event.find_or_create_by_name("Emergency Contact Numbers")

    end

def name_as_directory
    name.downcase.gsub(' ','-')
end


# loose match filename to event mapping
# map to an event

# per row

# --->create the plan from the tasks against each event


def generally_applicable_task? row
  # example row ["Items of special value", "√", "√", "√", "√", "√", "√"]
  row[1..6].reduce(true){ |c,e| c && e == "√" }
end

ORDERED_TAGS = [:alone, :not_alone, :children, :not_children, :pets, :not_pets]
def apply_tags_to task
  ORDERED_TAGS.each_with_index do |tag,idx|
    (task.tag_list.add(tag.to_s); t.save) if task[idx] == "√"
  end
end

def do_the_work filename, event
    CSV.read(filename).each do |row|
      task = Task.find_or_create_by_custom_and_name_and_event_id(false, row[0], event.id)
      next if generally_applicable_task? row
      apply_tags_to task
    end
end


# create the plan from the tasks against each event
    @person = Person.anon
    @person.save

    events.each do |event|
      tasks = Task.where(event_id: event.id)
      tasks.each do |original|
        duplicate = original.dup
        duplicate.custom = true

        if duplicate.save
          Allocation.create!(person_id: @person.id, task_id: duplicate.id)
        end
      end
    end

    @plan = Plan.new(name: name, postcode: postcode, is_public: true)
    @plan.save
    @plan.people << @person
# end create plan

  end

end