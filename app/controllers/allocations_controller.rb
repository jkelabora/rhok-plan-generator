class AllocationsController < ApplicationController

  respond_to :json

  def index
    @allocations = Allocation.all
    respond_with @allocations
  end

# curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"allocation":{"task_id":"2","person_id":"2"}}'  http://localhost:3000/allocations
  def create
    @allocation = Allocation.create!(params[:allocation])
    respond_with @allocation
  end
end