class AllocationsController < ApplicationController

  respond_to :json

  def index
    @plan = Plan.find_by_private_guid(params[:private_guid])
    plan = {owner: @plan.people.first, plan: @plan, events: [], kits: []}

    # Sorry about this.
    # This should really be a different category or something, flagged in the datadase
    other_matcher = "Kit|Contact"
    events = @plan.decorate.events

    normal_events = events.select {|event| not event.name.match other_matcher }
    normal_events.each do |event|
      plan[:events] << {
        event: event,
        custom_tasks: @plan.decorate.tasks_for(event),
        public_tasks: event.tasks.where(custom: false)
      }
    end

    kits = events.select {|event| event.name.match other_matcher }
    kits.each do |event|
      plan[:kits] << {
        event: event,
        custom_tasks: @plan.decorate.tasks_for(event),
        public_tasks: event.tasks.where(custom: false)
      }
    end

    gon.plan = plan
    render :action => 'index'
  end

  def create
    if params[:event_id] && params[:name] # via 'Add item'
      # {"name"=>"new task", "id"=>"add", "person_id"=>"25", "event_id"=>"1", "action"=>"create", "controller"=>"allocations"}
      task = Task.new(custom: true, name: params[:name].strip, event_id: params[:event_id])
      if task.save
        alloc = Allocation.create!(person_id: params[:person_id], task_id: task.id)
        render :json => {task_name: task.name, allocation_id: alloc.id}
      else
        render :status => :unprocessable_entity, :json => {}
      end
    else # via drag-and-drop
      # curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"allocation":{"task_id":"2","person_id":"2"}}'  http://localhost:3000/allocations
      original = Task.find_by_id params[:allocation][:task_id]
      duplicate = original.dup
      duplicate.custom = true
      if duplicate.save
        alloc = Allocation.create!(person_id: params[:allocation][:person_id], task_id: duplicate.id)
        render :json => {task_name: duplicate.name, allocation_id: alloc.id}
      else
        render :status => :unprocessable_entity, :json => {}
      end
    end
  end

# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X DELETE http://localhost:3000/allocations/3
  def destroy
    alloc = Allocation.find(params[:id])
    if Allocation.delete(params[:id]) && Task.delete(alloc.task_id)
      render :json => {}
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

end
