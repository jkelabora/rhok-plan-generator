require 'prawn'

class PlansController < ApplicationController

  def create
    @anon = Person.new(name: 'anon', email: '', mobile: '') #TODO: optionally provide user form fields?
    @plan = Plan.new(params[:plan])
    @plan.people << @anon
    if @plan.save
      redirect_to plan_allocations_path(@plan.private_guid)
    else
      redirect_to home_index_path, :notice  => "Problem creating plan"
    end
  end

  def duplicate
    @source = Plan.find_by_public_guid(params[:public_guid])

    @anon = Person.new(name: 'anon', email: '', mobile: '')
    @duplicate = Plan.new( name: "#{@source.name}-COPY", postcode: @source.postcode )
    @duplicate.people << @anon
    if @duplicate.save
      render :js => "#{plan_allocations_path(@duplicate.private_guid)}"
    else
      redirect_to home_index_path, :notice  => "Problem duplicating plan"
    end

  end

  def download
    @plan = Plan.find_by_private_guid(params[:private_guid]).decorate
    respond_to do |format|
      format.pdf do 
        #save image
        File.open("#{Rails.root}/app/assets/images/map-#{@plan.private_guid}.png", 'wb') do |file|
          file.write(@plan.static_gmap)
        end
        render :layout => false
      end
    end
  end

  def show
    @plan = Plan.find_by_private_guid(params[:private_guid]).decorate
    @plan.process_geocoding
    @map_options =  {
      :map_options => { :type => "ROADMAP", auto_zoom: false, :zoom => 14},
      :markers     => { :data => @plan.to_gmaps4rails, :options => {:do_clustering => true} }
    }
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
