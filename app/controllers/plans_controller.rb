class PlansController < ApplicationController
  def index
    @plans = Plan.all
  end

  def create
    @plan = Plan.new(params[:plan])
    if @plan.save
      redirect_to @plan, :notice => "Successfully created plan."
    else
      render :action => 'new'
    end
  end

  def new
    @plan = Plan.new
  end

  def show
    @plan = Plan.find(params[:id])
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(params[:plan])
      redirect_to @plan, :notice  => "Successfully updated plan."
    else
      render :action => 'edit'
    end
  end
end
