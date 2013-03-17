class HomeController < ApplicationController

  def index
    (1..4).each do |i|
      instance_variable_set :"@person#{i}", Person.new
    end

    render 'index'
  end

  def page_two
  	render 'page_two'
  end

  def page_three
  	render 'page_three'
  end

  def page_four
  	render 'page_four'
  end

end
