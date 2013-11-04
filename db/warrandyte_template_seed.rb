# rails runner -S db/warrandyte_template_seed.rb

# find:    ^((?!event).*)\n
# replace: Task.find_or_create_by_custom_and_name_and_event_id(false, "$1", event.id)\n

class DestructiveTemplateLoad
  def clear_out_all_data_and_load_warrandyte_template_plan

    Allocation.destroy_all
    Person.destroy_all
    Plan.destroy_all
    Task.destroy_all
    Event.destroy_all


    events = []
    events << Event.find_or_create_by_name("Before the bushfire season")
    events << Event.find_or_create_by_name("On a day when SEVERE, EXTREME or CODE RED Fire Danger has been predicted")
    events << Event.find_or_create_by_name("Should leaving early be impossible")
    events << Event.find_or_create_by_name("If fire directly threatens the house")
    events << Event.find_or_create_by_name("When the fire front has passed")
    events << Event.find_or_create_by_name("Relocation Kit")
    events << Event.find_or_create_by_name("Emergency Kit")
    events << Event.find_or_create_by_name("Emergency Contact Numbers")


    event = events[0]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Clean up all rubbish around the house, keep grass mown and whipper snipped, including nature strip. Move woodpile well away from house to southern fence boundary.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove all branches and overhanging the house. (Utilise Council's green waste service or vouchers).", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check all smoke alarms, and replace batteries if necessary.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Clean out all gutters, including sheds/garage. Check fire mesh over vents around the house.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Pack emergency kit in a large plastic container for quick transportation - photographs, backup discs, medications and prescriptions, insurance documents, passports, cameras, paintings, jewellery, etc. (see Emergency Kit section). Keep this kit in an accessible spot.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Keep mobile phones charged throughout the bushfire season and carry at all times.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify where to go on a SEVERE, or greater, fire risk day.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Make arrangements for all animals to be transported safely.", event.id)#pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Define responsibilities and make arrangements for all family to be transported safely.", event.id)#!alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Practise our leave early plan with all the family. Make sure everyone knows their role and how scary a bushfire can be.", event.id)#!alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Practise how to leave early.", event.id)#alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Discuss your fire plan with direct neighbours, and exchange contact information to ensure we are all able to keep in touch in an emergency.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise the children's schools of our plans to leave early on a SEVERE, or greater, fire risk day.", event.id)#children
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Place mops and metal buckets in an accessible location with the Emergency Kit", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Discuss with the entire family where we would shelter in the house if unable to leave.", event.id)#!alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify where to shelter in the house if unable to leave.", event.id)#alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Inform the children that we will expect them to stay at school should a fire start during school hours, as both schools have fire protocols in place for emergencies.", event.id)#children
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Ensure all house entrance points are clear of all combustible items/materials for at least 10 metres.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check hoses can be moved into the house, connect them to the washing machine taps and test they fit/connect.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Keep a close watch on the weather conditions.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify your trigger to leave eg. Total Fire Ban, SEVERE or greater Fire Danger Rating.", event.id)

    event = events[1]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Decide whether to leave the night before or early the next morning (by 8.00am or earlier if CODE RED, by 10.00am if EXTREME, or by 11.00am if SEVERE).", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check the Warrandyte Fire Watch site warrandyte.org.au/fire-watch/", event.id)


    Task.find_or_create_by_custom_and_name_and_event_id(false, "Move any outdoor furniture, other flammable items, doormats and items which may be dangerous in high winds into the garage, including BBQ gas bottle. ", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Divert the home phone to a mobile.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Take the car, pets and your Emergency Kit and head for your relative's or friend's place. Remain there until the danger has passed.", event.id)#alone and pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Take the cars, all family members, pets and our Emergency Kit and head for our relative's or friend's place. Remain there until the danger has passed.", event.id)#!alone and pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Take the cars, all family members and our Emergency Kit and head for our relative's or friend's place. Remain there until the danger has passed.", event.id)#!alone !pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Prepare for a probable delay crossing the bridge at Warrandyte so as to avoid a panic.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "If a school day, notify the teachers our children will not be attending until further notices (see Emergency Contact Numbers)", event.id)#children
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continually monitor 774KHz AM (ABC Radio) and cfa.vic.gov.au/incidents/incident_summary.htm for emergency information.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise neighbours, close friends and relatives of the plan to leave early.", event.id)

    event = events[2]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Can we get to the Neighbourhood Safer Place - Warrandyte Reserve - as a LAST RESORT? If not then follow the steps below.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check the Warrandyte Fire Watch site warrandyte.org.au/fire-watch/", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Place the pets in the downstairs laundry area with water and food.", event.id)#pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Block all downpipes with gutter plugs, tennis balls or rags and fill gutters with water.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Move cars into the garage and close the door.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Turn off the Gas supply at the main.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Divert the home phone to a mobile and carry that mobile at all times.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove from Emergency Kit, and everyone put on their fire protection clothing and gear - including masks. Hand out torches and fill and place metal buckets at front and back doors, with mops and wheelie bins filled with water.", event.id)#!alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove from Emergency Kit, and put on fire protection clothing and gear - including mask. Grab the torch and fill and place metal buckets at front and back doors, with mops and wheelie bins filled with water.", event.id)#alone
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Monitor 774KHz AM (ABC Radio) and cfa.vic.gov.au/incidents/incident_summary.htm on computer (assuming power is still available).", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Close all windows and doors (do not lock) and leave blinds up.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Turn off the air conditioner.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Fill all baths and basins/sinks (upstairs and downstairs), and soak some towels, the towels to be used to seal under doors. Dry woollen blankets can cover the family in the event of the need to directly face the fire.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continually monitor externally for ember attack.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Place a ladder, torch and Supersoaker (powerful water pistol) at the upstairs manhole to monitor roof space.", event.id)

    event = events[3]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Wet down all front and back decks and keep them wet.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Drench fire-facing walls, and continually monitor for spot fires.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "When fire intensity becomes to great - retreat inside, move hoses into the house and connect them to the washing machine taps.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continually patrol house/ceiling with hoses to prevent internal fire.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Block under exterior doorways with wet towels.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check roof space regularly.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Make sure pets are restrained.", event.id)#pets
    Task.find_or_create_by_custom_and_name_and_event_id(false, "If the house catches fire move away from the source and shut doors behind us to isolate and slow down the burning parts of the house. The last room to retreat to must be the one with an exit (probably downstairs laundry). (Hopefully the fire front will have passed by the time we are forced into the downstairs laundry).", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "If the laundry is no longer safe move outside to the south side (back) of the house (against the brick wall) and cover up with dry woollen blankets and shelter there until the fire passes.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Try to manage the pets but do not let anyone go after them should they escape - stay together.", event.id)#pets

    event = events[4]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Go around the house checking for embers and spot fires, and dousing these with the hose, mops and buckets etc.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Keep drinking plenty of water.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "When all is OK, advise relatives or friends.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Check status of neighbours and street, including power lines, etc and report any problems via mobile phone to the CFA or Police.", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Continue to monitor for spot fires.", event.id)

    event = events[5]
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Large container with lid", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Photographs", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Back up discs and 2 TB backup drive", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Medications and prescriptions", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Important documents (insurance, passports, etc)", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Cameras", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Paintings", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Jewellery", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Address book and diary", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Mobile phone chargers", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Clothes for three days", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Toiletries", event.id)
    Task.find_or_create_by_custom_and_name_and_event_id(false, "Dog leads and food, bird seed and water", event.id)#pets
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

    @plan = Plan.new(name: 'Warrandyte Template', postcode: '3113', opt_out: false)
    @plan.save
    @plan.people << @person

  end
end