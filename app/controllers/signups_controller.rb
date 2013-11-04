class SignupsController < ApplicationController

  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(params)

    if @signup.save
      @event = Event.first
      @events = Event.all

      @plan = @signup.plan
      @people = [@signup.person]

      @custom_tasks = Task.where(event_id: @event).where(custom: true)  #TODO: should be a scope
      @public_tasks = Task.where(event_id: @event).where(custom: false)  #TODO: should be a scope

      @allocations = Allocation.where(task_id: @custom_tasks).where(people_id: @people)

      redirect_to plan_allocations_path(@plan.private_guid)
    else
      render "new"
    end
  end
end


