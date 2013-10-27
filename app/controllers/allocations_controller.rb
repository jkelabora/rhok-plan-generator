class AllocationsController < ApplicationController

  respond_to :json

  def index
    @event = begin
      if params[:id] then
        Event.find(params[:id]) rescue Event.first
      else
        Event.first
      end
    end
    @events = Event.all

    @plan = Plan.find_by_private_guid params[:private_guid]
    @people = Person.where(plan_id: @plan)

    @custom_tasks = Task.where(event_id: @event).where(custom: true)  #TODO: should be a scope
    @public_tasks = Task.where(event_id: @event).where(custom: false)  #TODO: should be a scope

    @allocations = Allocation.where(task_id: @custom_tasks).where(people_id: @people)

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