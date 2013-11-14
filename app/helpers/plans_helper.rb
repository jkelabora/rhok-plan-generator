module PlansHelper

  def table_header_values(name)
      ["Relocation Kit",  "Emergency Kit"].include?(name) ?
          [["Allocated to", "Items to include", "Done?"]] :
          [["Allocated to", "Task to complete", "Done?"]]
  end
end
