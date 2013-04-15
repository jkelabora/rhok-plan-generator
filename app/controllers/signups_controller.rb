class SignupsController < ApplicationController

  def new
    @persons = [Person.new, Person.new]
  end

  def create

    # @signup = Signup.new(params[:signup]).whatevs
    @signup = Signup.new(params.select{|p|p.start_with? 'p_'})

    if @signup.save
      # redirect_to dashboard_path

      # flash[:notice] = "Plan and two people successfully created"
      # @persons = [Person.new, Person.new]
      render "signups/page_two"
    else
      render "new"
    end
  end
end


