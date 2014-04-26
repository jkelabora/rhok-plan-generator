module MailtoHelper

  def feedback_mailto
    "mailto:feedback@whatstheplan.net"
  end

  def share_mailto plan
    "mailto:?Subject=Link%20to%20the%20plan%20%27#{plan.escaped_name}%27&Body=#{plan_edit_url(:private_guid => plan.private_guid)}"
  end

end