class SharedPlansController < ApplicationController

  def show
    shareable_plan = ShareablePlan.find_by_guid(params[:id])
    redirect_to '/' and return if shareable_plan == nil

    @plan = shareable_plan.plan.decorate
    if shareable_plan.kind_of?(PublicPlan)
      render :file => 'plans/download.pdf.prawn', content_type => 'application/pdf' and return
    end
    render 'plans/show'
  end    

end