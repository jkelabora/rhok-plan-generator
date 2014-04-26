module MailtoHelper

  def feedback_mailto
    "mailto:feedback@whatstheplan.net"
  end

  def share_mailto plan
    [
      "mailto:?",
      "Subject=Links for the plan %27#{plan.escaped_name}%27&",
      "Body=",
      "To return to the plan customisation page use:",
      crlf,
      "#{plan_edit_url(:private_guid => plan.private_guid)}",
      crlf, crlf,
      "or to share a read-only view of your plan with someone else send them:",
      crlf,
      "#{plan_url(:public_guid => plan.public_guid)}",
      crlf, crlf
    ].join.gsub(' ', space)
  end

  private
  def crlf;  "%0D%0A"; end
  def space; "%20";    end

end