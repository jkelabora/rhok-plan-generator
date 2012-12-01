require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_create_invalid
    Plan.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Plan.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to plan_url(assigns(:plan))
  end

  def test_show
    get :show, :id => Plan.first
    assert_template 'show'
  end

  def test_edit
    get :edit, :id => Plan.first
    assert_template 'edit'
  end

  def test_update_invalid
    Plan.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Plan.first
    assert_template 'edit'
  end

  def test_update_valid
    Plan.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Plan.first
    assert_redirected_to plan_url(assigns(:plan))
  end
end
