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

# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"allocation":{"task_id":"2","person_id":"2"}}'  http://localhost:3000/allocations
  def create
    original = Task.find_by_id params[:allocation][:task_id]
    duplicate = original.dup
    duplicate.custom = true
    if duplicate.save
      Allocation.create!(person_id: params[:allocation][:person_id], task_id: duplicate.id)

      event = Event.find(params[:id])
      person = Person.find(params[:allocation][:person_id])
      tasks = person.tasks.where(event_id: event).where(custom: true)  #TODO: should be a scope
      allocations = person.allocations.where(task_id: tasks)

      render :json => {
        person_id: person.id,
        allocations: allocations.collect{|a|
          { id: a.id,
           name: a.task.name
          }
        }
      }.to_json
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X DELETE http://localhost:3000/allocations/3
  def destroy
    if Allocation.delete(params[:id])
      render :json => {}
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

end