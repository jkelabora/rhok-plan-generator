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

  end

  def destroy
    task = Task.find(params[:id])
    allocs = Allocation.where(task_id: params[:id])
    if task.delete && allocs.destroy_all
      render :json => {}
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

  def update
    task = Task.find(params[:id])
    task.name = params[:name]
    if task.save
      render :json => params[:name]
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

end
