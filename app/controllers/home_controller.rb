class HomeController < ApplicationController

  def index
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