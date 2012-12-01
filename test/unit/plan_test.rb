require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Plan.new.valid?
  end
end
