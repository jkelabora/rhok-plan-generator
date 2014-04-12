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
      tasks << person.tasks.where(event_id: event)
    end
    tasks.flatten.uniq
  end

  def suggested_tasks_for(event)
    suggested_tasks_already_on_plan = tasks_for(event).collect{|t| t.parent_task }.compact
    event_tasks = event.tasks.where(custom: false)
    event_tasks - suggested_tasks_already_on_plan
  end

  def people_for(task)
    task.people.collect(&:name).join(', ')
  end

end
