
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
    def load

        return unless Plan.where(name: name, postcode: postcode).empty?

        setup_events
        require 'csv'
        Dir.glob(File.join(Rails.root,"fixtures/#{name_as_directory}/*")).each do |filename|
            load_all_tasks_and_tag_for filename
        end
        setup_the_plan
    end

    private

    def find_matching_event filename
        event_name = filename.match(/.*JC - (.*)\.csv/)[1]
        event = Event.find_by_name event_name
        raise "couldn't find matching event for #{filename}" unless event
        event
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

    def generally_applicable_task? row
      # example row ["Items of special value", "Y", "Y", "Y", "Y", "Y", "Y"]
      row[1..6].reduce(true){ |c,e| c && e == "Y" }
    end

    ORDERED_TAGS = [:alone, :not_alone, :children, :not_children, :pets, :not_pets]
    def apply_tags_to task, row
      ORDERED_TAGS.each_with_index do |tag,idx|
        (task.tag_list.add(tag.to_s); task.save) if row[idx+1] == "Y"
      end
    end

    def find_matching_event filename
        event_name = filename.match(/.*JC - (.*)\.csv/)[1]
        event = Event.find_by_name event_name
        raise "couldn't find matching event for #{filename}" unless event
        event
    end

    def create_tasks_and_tag filename, event
        CSV.read(filename).each do |row|
          task = Task.find_or_create_by_custom_and_name_and_event_id(false, row[0], event.id)
          next if generally_applicable_task? row
          apply_tags_to task, row
        end
    end

    def load_all_tasks_and_tag_for filename
        create_tasks_and_tag filename, find_matching_event(filename)
    end

    def setup_the_plan
        anon = Person.anon
        anon.save

        events.each do |event|
          tasks = Task.where(event_id: event.id)
          tasks.each do |original|
            duplicate = original.dup
            duplicate.custom = true

            if duplicate.save
              Allocation.create!(person_id: anon.id, task_id: duplicate.id)
            end
          end
        end

        template_plan = Plan.new(name: name, postcode: postcode, is_public: true)
        template_plan.save
        template_plan.people << anon
    end

end

