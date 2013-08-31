class TasksController < ApplicationController

  def create
    @task = Task.new(params[:task])
    if @task.save
      redirect_to @task, :notice => "Successfully created task."
    else
      render :action => 'new'
    end
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
