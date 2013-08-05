pdf.text "Fire Plan - #{@plan.name}", :size => 30, :style => :bold
pdf.text "Postcode  #{@plan.postcode}", :size => 20, :style => :bold

pdf.move_down(30)

@plan.events.each do |event|
    pdf.text "#{event.name}", :size => 20, :style => :bold
    items = @plan.tasks_for(event).map do |task|
        [
            @plan.people_for(task),
            task.name
        ]
    end

    pdf.table items

    pdf.move_down(20)
end
