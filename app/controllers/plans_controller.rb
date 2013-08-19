require 'prawn'

class PlansController < ApplicationController

  def index
    @plans = Plan.all
  end

  def create
    # may need to create an anonymous user at this point depending on the entry point..
    @plan = Plan.new(params[:plan].merge(postcode: 3113))
    if @plan.save
      redirect_to @plan, :notice => "Successfully created plan."
    else
      render :action => 'new'
    end
  end

  def duplicate
    @source = Plan.find_by_public_guid(params[:public_guid])
    h = { name: (@source.name + '-copied'), postcode: @source.postcode }
    
    # need to create an anonymous user at this point..

    if @new = Plan.create(h)
      redirect_to @new, :notice => "Successfully duplicated plan."
    else
      render :action => 'new'
    end

  end

  def show
    @plan = Plan.find(params[:id]).decorate
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def download
    @plan = Plan.find(params[:plan_id]).decorate
    respond_to do |format|    
      format.pdf { render :layout => false}
    end
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
