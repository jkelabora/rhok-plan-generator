require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_create_invalid
    Person.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Person.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to people_url
  end
end
