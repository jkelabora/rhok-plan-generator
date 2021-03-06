class TasksController < ApplicationController

  respond_to :json

  def create
    if params[:original_guid] # via moveTask
      original = Task.find_by_guid params[:original_guid]
      duplicate = original.dup
      duplicate.custom = true
      duplicate.parent_task = original
      if duplicate.save
        alloc = Allocation.create!(person_id: params[:owner_id], task_id: duplicate.id)
        render :json => {
          created_at: duplicate.created_at,
          custom: true,
          guid: duplicate.guid,
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
          guid: task.guid,
          name: task.name,
          updated_at: task.updated_at
        }
      else
        render :status => :unprocessable_entity, :json => {}
      end
    end

  end

  def destroy
    task = Task.find_by_guid(params[:guid])
    allocs = Allocation.where(task_id: task.id)
    if task.delete && allocs.destroy_all
      render :json => {}
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

  def update
    task = Task.find_by_guid(params[:guid])
    task.name = params[:name]
    if task.save
      render :json => params[:name]
    else
      render :status => :unprocessable_entity, :json => {}
    end
  end

end
