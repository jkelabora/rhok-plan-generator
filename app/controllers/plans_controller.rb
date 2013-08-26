require 'prawn'

class PlansController < ApplicationController

  def create
    @anon = Person.new(name: 'anon', email: '', mobile: '') #TODO: optionally provide user form fields?
    @plan = Plan.new(params[:plan].merge(postcode: 3113))
    @plan.people << @anon
    if @plan.save
      redirect_to plan_allocations_path(@plan.private_guid)
    else
      redirect_to home_index_path(postcode: 3113), :notice  => "Problem creating plan"
    end
  end

  def duplicate
    @source = Plan.find_by_public_guid(params[:public_guid])
    
    @anon = Person.new(name: 'anon', email: '', mobile: '')
    @duplicate = Plan.new( name: "#{@source.name}-COPY", postcode: @source.postcode )
    @duplicate.people << @anon
    if @duplicate.save
      redirect_to plan_allocations_path(@duplicate.private_guid)
    else
      redirect_to home_index_path(postcode: 3113), :notice  => "Problem duplicating plan"
    end

  end

  def download
    @plan = Plan.find_by_private_guid(params[:private_guid]).decorate
    respond_to do |format|    
      format.pdf { render :layout => false}
    end
  end  

  def show
    @plan = Plan.find_by_public_guid(params[:public_guid]).decorate
  end

  # leave as a json endpoint.. will need to edit plan details at some point
  def update
    @plan = Plan.find(params[:id])
    if @plan.update_attributes(params[:plan])
      redirect_to @plan, :notice  => "Successfully updated plan."
    else
      render :action => 'edit'
    end
  end

end
