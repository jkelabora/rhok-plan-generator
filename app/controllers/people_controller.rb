class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def create
    @person = Person.new(params[:person])
    if @person.save
      redirect_to people_url, :notice => "Successfully created person."
    else
      render :action => 'new'
    end
  end
end
