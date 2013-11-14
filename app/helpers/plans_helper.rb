module PlansHelper

  def table_header_values(name)
      name == "Relocation Kit" ? [["Assignee(s)", "Items to include", "Done?"]] : [["Assignee(s)", "Task to complete", "Done?"]]
  end
end
