class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def create

    if Person.create_multiple params
      redirect_to people_url, :notice => "Successfully created person."
    else
      render :action => 'new'
    end
  end
end
