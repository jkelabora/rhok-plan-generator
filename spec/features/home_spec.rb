require 'features/spec_helper'

describe "a plan", :type => :feature do

  before :each do
  end

	it "should print a PDF of the plan" do
    visit "/signups"
    fill_in 'signup_plan_name', :with => 'testes'
    fill_in 'signup_postcode', :with => '3113'
    click_button('Next >>')
    click_button('PDF')
    page.status_code.should == 200
    page.response_headers['Content-Type'].should match 'application/pdf'
  end

end
