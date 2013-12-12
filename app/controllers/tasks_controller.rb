class TasksController < ApplicationController

  respond_to :json

  def create
    if params[:task_id] # via moveTask
      original = Task.find_by_id params[:task_id]
      duplicate = original.dup
      duplicate.custom = true
      if duplicate.save
        alloc = Allocation.create!(person_id: params[:owner_id], task_id: duplicate.id)
        render :json => {
          created_at: duplicate.created_at,
          custom: true,
          id: duplicate.id,
          name: duplicate.name,
          updated_at: duplicate.updated_at
        }
      else
        render :status => :unprocessable_entity, :json => {}
      end
    else # via addTask
      task = Task.new(custom: true, name: params[:name].strip, event_id: params[:event_id])
      if task.save
        alloc = Allocation.create!(person_id: params[:owner_id], task_id: task.id)
        render :json => {
          created_at: task.created_at,
          custom: true,
          id: task.id,
          name: task.name,
          updated_at: task.updated_at
        }
      else
        render :status => :unprocessable_entity, :json => {}
      end
    end



    # @task = Task.new(params[:task])
    # if @task.save
    #   redirect_to @task, :notice => "Successfully created task."
    # else
    #   render :action => 'new'
    # end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to @task, :notice  => "Successfully updated task."
    else
      render :action => 'edit'
    end
  end
end
