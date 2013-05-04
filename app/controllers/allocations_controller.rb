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
    @tasks = Task.where(event_id: @event)
    @people = Person.all
    @allocations = Allocation.where(task_id: @tasks)
    render :action => 'index'
  end

# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"allocation":{"task_id":"2","person_id":"2"}}'  http://localhost:3000/allocations
  def create
    Allocation.create!(params[:allocation])
    @event = Event.find(params[:id])
    @tasks = Task.where(event_id: @event)
    @people = Person.all
    @allocations = Allocation.where(task_id: @tasks)
    render :json => @allocations.to_json(except: ['created_at', 'updated_at'])
  end

# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X DELETE http://localhost:3000/allocations/3
  def destroy
    Allocation.delete(params[:id])
    render :json => {}
  end

end