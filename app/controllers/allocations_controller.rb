class AllocationsController < ApplicationController

  respond_to :json

  def index
    @allocations = Allocation.all
    @people = Person.all
    @tasks = Task.all
    render :action => 'index'
  end

# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"allocation":{"task_id":"2","person_id":"2"}}'  http://localhost:3000/allocations
  def create
    Allocation.create!(params[:allocation])
    @allocations = Allocation.all
    render :json => @allocations.to_json(except: ['created_at', 'updated_at'])
  end
end