class TasksController < ApplicationController

  respond_to :json

  def create
    original = Task.find_by_id params[:task_id]
    duplicate = original.dup
    duplicate.custom = true
    if duplicate.save
      # alloc = Allocation.create!(person_id: params[:allocation][:person_id], task_id: duplicate.id)
      render :json => {
        created_at: duplicate.created_at,
        # custom: true
        id: duplicate.id,
        name: duplicate.name,
        updated_at: duplicate.updated_at
      }
    else
      render :status => :unprocessable_entity, :json => {}
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
