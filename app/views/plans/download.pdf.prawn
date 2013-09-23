pdf.repeat(:all) do
    pdf.draw_text "Fire Plan - #{@plan.name}", :at => [pdf.bounds.left - 0, 8], :style => :italic, :size => 10
    pdf.number_pages "Page <page> of <total>", :at => pdf.bounds.bottom_left, :style => :italic, :size => 10
    pdf.draw_text "Generated at: #{Time.now}", :at => [pdf.bounds.right - 180, -8], :style => :italic, :justify => :right, :size => 10
end

pdf.text "Fire Plan - #{@plan.name}", :size => 30, :style => :bold
pdf.text "Postcode  #{@plan.postcode}", :size => 20, :style => :bold

pdf.move_down(10)
pdf.text "Share the online version of this plan (in read-only form) using <u>#{link_to plan_url(@plan.public_guid), plan_url(@plan.public_guid)}</u>", :inline_format => true if @plan.public?
pdf.move_down(5)
pdf.text "Return to edit this plan online <u>#{link_to plan_allocations_url(:private_guid => @plan.private_guid), plan_allocations_url(:private_guid => @plan.private_guid)}</u>", :inline_format => true

pdf.move_down(30)

@plan.events.each do |event|
    pdf.text "#{event.name}", :size => 20, :style => :bold
    pdf.move_down(10)

    items = [["Assignee", "Task to complete", "Done?"]]
    items += @plan.tasks_for(event).collect do |task|
        [
            @plan.people_for(task),
            task.name,
            ''
        ]
    end

    pdf.table items, :row_colors => ["CBCBCB", "F0F0F0"], :column_widths => [100, 390, 50] do # full possible table width = 540
        row(0).font_style = :bold
    end

    pdf.move_down(20)
end
