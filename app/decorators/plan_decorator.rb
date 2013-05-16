class PlanDecorator < Draper::Decorator

  delegate_all

  def events
    events = []
    object.people.each do |person|
      events << person.tasks.collect(&:event)
    end
    events.flatten.uniq
  end

  def tasks_for(event) 
    tasks = []
    object.people.each do |person|
      tasks << person.tasks.all { |task| task.event == event }
    end
    tasks.flatten.uniq
  end

  def people_for(task)
    task.people.collect(&:name).join(', ')
  end

end
