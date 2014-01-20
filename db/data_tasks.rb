
# find:    ^((?!event).*)\n
# replace: Task.find_or_create_by_custom_and_name_and_event_id(false, "$1", event.id)\n

class WhiteListedDataDestroyer

  def clear_out_all_plans_and_data_except_for_these_plans

    candidate_ids = Plan.pluck(:id) - yield
    Plan.find_all_by_id(candidate_ids).each do |plan|
        plan.people.each { |person|
            person.tasks.destroy_all
            person.allocations.destroy_all
            person.destroy
            plan.destroy
        }
    end

  end

end

class OnceOffTemplateLoad

  # designed to only persist data once (despite subsequent executions) to preserve updates via ActiveAdmin 
  def load_template_plan name, postcode

    return unless Plan.where(name: name, postcode: postcode).empty?

    events = []
    events << Event.find_or_create_by_name("Before the bushfire season")
    events << Event.find_or_create_by_name("On a high risk day")
    events << Event.find_or_create_by_name("Should leaving early be impossible")
    events << Event.find_or_create_by_name("If fire directly threatens the house")
    events << Event.find_or_create_by_name("When the fire front has passed")
    events << Event.find_or_create_by_name("Relocation Kit")
    events << Event.find_or_create_by_name("Emergency Kit")
    events << Event.find_or_create_by_name("Emergency Contact Numbers")

    tag_with = {
        pets: [],
        not_pets: [],
        alone: [],
        not_alone: [],
        children: [],
        not_children: []
    }

    event = events[0]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Clean up all rubbish around the house, keep grass mown and whipper snipped, including nature strip. Move woodpile well away from house to southern fence boundary.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove all branches overhanging the house. (Utilise Council's green waste service or vouchers).", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check all smoke alarms, and replace batteries if necessary.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Clean out all gutters, including sheds/garage. Check fire mesh over vents around the house.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Pack emergency kit in a container or bag for quick transportation - photographs, medications/ prescriptions, important documents (insurance details), passports, cameras, paintings, jewellery, backup discs, etc. (see Emergency Kit section). Keep this kit in an accessible spot.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Keep mobile phones charged throughout the bushfire season and carry at all times.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify where to go on a SEVERE, or greater, fire risk day.", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Make arrangements for all animals to be transported safely.", event.id)#pets
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Make arrangements for all family to be transported safely.", event.id)#!alone
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Define responsibilities - which household member will perform each task.", event.id)#!alone
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Discuss and agree our plan as a household.", event.id)#!alone
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Practise our leave early plan with all the family. Make sure everyone knows their role and how scary a bushfire can be.", event.id)#!alone
    tag_with[:alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Practise how to leave early.", event.id)#alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Discuss your fire plan with direct neighbours, and exchange contact information to ensure we are all able to keep in touch in an emergency.", event.id)
    tag_with[:children] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise the children's schools of our plans to leave early on a SEVERE, or greater, fire risk day.", event.id)#children
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Place mops and metal buckets in an accessible location with the Emergency Kit", event.id)
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Discuss with the entire family where we would shelter in the house if unable to leave.", event.id)#!alone
    tag_with[:alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify where to shelter in the house if unable to leave.", event.id)#alone
    tag_with[:children] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Inform the children that we will expect them to stay at school should a fire start during school hours, as both schools have fire protocols in place for emergencies.", event.id)#children
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Ensure all house entrance points are clear of all combustible items/materials for at least 10 metres.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check hoses can be moved into the house, connect them to the washing machine taps and test they fit/connect.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify your trigger to leave eg. Total Fire Ban, SEVERE or greater Fire Danger Rating.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Decide where you are going to obtain your bushfire information from during the bushfire season and download associated apps or bookmark relevant webpages. Eg. CFA Fire Ready, Emergency Aus, Warrandyte Fire Watch, preset 774AM on radio.", event.id)
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise neighbours, close friends and relatives of our plan and where you will go when we leave.", event.id)
    tag_with[:alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise neighbours, close friends and relatives of my plan and where I will go when I leave.", event.id)
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Source enough woollen blankets for every household member to use for protection should the need arise. Consider obtaining blankets for visitors.", event.id)
    tag_with[:alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Source enough woollen blankets to use for protection should the need arise. Consider obtaining blankets for visitors.", event.id)

    event = events[1]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check the Warrandyte Fire Watch site warrandyte.org.au/fire-watch/", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Move any outdoor furniture, other flammable items, doormats and items which may be dangerous in high winds into the garage, including BBQ gas bottle. ", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Divert the home phone to a mobile and carry that mobile at all times.", event.id)

    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Take the car/s, pets and your Emergency Kit and head for our designated relocation relative's or friend's place. Remain there until the danger has passed.", event.id)
    tag_with[:not_pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Take the car/s, all family members and our Emergency Kit and head for our designated reloaction relative's or friend's place. Remain there until the danger has passed.", event.id)

    Task.find_or_create_by_custom_and_name_and_event_id(false, "Prepare for a probable delay crossing the bridge at Warrandyte so as to avoid a panic.", event.id)
    tag_with[:children] << Task.find_or_create_by_custom_and_name_and_event_id(false, "If a school day, notify the teachers our children will not be attending until further notices (see Emergency Contact Numbers)", event.id)#children
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continually monitor 774KHz AM (ABC Radio) and cfa.vic.gov.au/incidents/incident_summary.htm for emergency information.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise neighbours, close friends and relatives of the plan to leave early.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Decide whether to leave the night before or early the next morning (by 8.00am or earlier if CODE RED, by 10.00am if EXTREME, or by 11.00am if SEVERE).", event.id)
    tag_with[:not_pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Place livestock in a well-grazed paddock with room for them to move freely. Do not lock horses in a stable, holding yard or similar environment.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Block all downpipes with gutter plugs, tennis balls or rags and fill gutters with water.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Turn off the Gas supply at the main.", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove all rugs and head collars from livestock.", event.id)

    event = events[2]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check the Warrandyte Fire Watch site warrandyte.org.au/fire-watch/", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Place the pets in the designated space with water and food.", event.id)#pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Block all downpipes with gutter plugs, tennis balls or rags and fill gutters with water.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Move cars into the garage and close the door.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Turn off the Gas supply at the main.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Divert the home phone to a mobile and carry that mobile at all times.", event.id)
    tag_with[:not_alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove from Emergency Kit, and everyone put on their fire protection clothing and gear - including masks. Hand out torches and fill and place metal buckets at front and back doors, with mops and wheelie bins filled with water.", event.id)#!alone
    tag_with[:alone] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove from Emergency Kit, and put on fire protection clothing and gear - including mask. Grab the torch and fill and place metal buckets at front and back doors, with mops and wheelie bins filled with water.", event.id)#alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Monitor 774KHz AM (ABC Radio) and cfa.vic.gov.au/incidents/incident_summary.htm on computer (assuming power is still available).", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Close all windows and doors (do not lock) and leave blinds up.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Turn off the air conditioner.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Fill all baths and basins/sinks (upstairs and downstairs), and soak some towels, the towels to be used to seal under doors. Dry woollen blankets can cover the family in the event of the need to directly face the fire.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continually monitor externally for ember attack.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Place a ladder, torch and Supersoaker (powerful water pistol) at the upstairs manhole to monitor roof space.", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove all rugs and head collars from livestock.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise family, friends and/or neighbours that you are on site and have been unable to leave.", event.id)

    event = events[3]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Wet down all front and back decks and keep them wet.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Drench fire-facing walls, and continually monitor for spot fires.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "When fire intensity becomes too great - retreat inside, move hoses into the house and connect them to the washing machine taps.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continually patrol house/ceiling with hoses to prevent internal fire.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Block under exterior doorways with wet towels.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check roof space regularly.", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Make sure small pets are restrained.", event.id)#pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "If the house catches fire move away from the source and shut doors behind us to isolate and slow down the burning parts of the house. The designated last room to retreat to must be the one with an exit (probably downstairs laundry). (Hopefully the fire front will have passed by the time we are forced into the designated room).", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "If the designated room is no longer safe, and if it is safe to do so, move outside to the safest side of the house that will offer the most protection from radiant heat (against the brick wall) and cover up with dry woollen blankets and shelter there until the fire passes.", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Try to manage the pets but do not let anyone go after them should they escape - stay together.", event.id)#pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Do not retreat to a bathroom - they are generally an unsafe room as they only have one exit and windows are frosted for privacy - which does not allow you to see outside.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Draw curtains, but maintain a view of the conditions outside.", event.id)

    event = events[4]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Go around the house checking for embers and spot fires, and dousing these with the hose, mops and buckets etc.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Keep drinking plenty of water.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "When all is OK, advise relatives or friends.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check status of neighbours and street, including power lines, etc and report any problems via mobile phone to the CFA or Police.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continue to monitor for spot fires.", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Check pets/livestock for burns and administer first aid until able to obtain veterinary treatment. All first aid administered should be anti-inflammatory.", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Provide plenty of clean drinking water for all pets/livestock and/or native animals.", event.id)

    event = events[5]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Large container with lid or bag to hold relocation items", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Photographs", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Back up discs and and/or backup drive", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Medications and prescriptions", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Important documents (insurance, passports, proof of identity, banking info, credit cards, etc)", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Jewellery", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Address book and diary", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Mobile phone chargers", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Clothes for three days", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Toiletries", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Dog leads and food, bird seed and water", event.id)#pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Money", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Items of special value", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Supplies (food, formula, snacks, medications, bottles etc)", event.id)

    event = events[6]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "NOTE: The following items are to only in case leaving early is impossible.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Woollen Blankets", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Hard Hats", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Leather gloves", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "P2 Smoke masks", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Protective clothing (long-sleeved woollen shirts, jean, boots)", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Plenty of water", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Enough food for 3 days", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Battery operated radio", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Torches and spare batteries", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Supersoaker (powerful water pistol)", event.id)

    event = events[7]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Fire, Police, Ambulance: 000", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Warrandyte Police: 9844 3231", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Manningham Council: 9840 9333", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Nillumbik Council: 9433 3111", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Victorian Bushfire Information Line: 1800 240 667", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Insurance company", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Doctor", event.id)
    tag_with[:pets] << Task.find_or_create_by_custom_and_name_and_event_id(false, "Vet", event.id)
    tag_with[:children] << Task.find_or_create_by_custom_and_name_and_event_id(false, "School", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Family", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Neighbours", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Friends", event.id)


    tag_with.each{|k,v| v.each{|t| t.tag_list.add(k.to_s); t.save } }

    @person = Person.anon
    @person.save

    events.each do |event|
      tasks = Task.where(event_id: event.id)
      tasks.each do |original|
        duplicate = original.dup
        duplicate.custom = true

        if duplicate.save
          Allocation.create!(person_id: @person.id, task_id: duplicate.id)
        end
      end
    end

    @plan = Plan.new(name: name, postcode: postcode, is_public: true)
    @plan.save
    @plan.people << @person

  end

end