# rails runner -S db/warrandyte_template_seed.rb

# find:    ^((?!event).*)\n
# replace: Task.find_or_create_by_custom_and_name_and_event_id(false, "$1", event.id)\n

Allocation.destroy_all
Person.destroy_all
Plan.destroy_all
Task.destroy_all
Event.destroy_all


events = []
events << Event.find_or_create_by_name("Before the bushfire season")
events << Event.find_or_create_by_name("On a day when SEVERE, EXTREME or CODE RED Fire danger has been predicted")
events << Event.find_or_create_by_name("Should leaving early be impossible")
events << Event.find_or_create_by_name("If fire directly threatens the house")
events << Event.find_or_create_by_name("When the fire front has passed")
events << Event.find_or_create_by_name("Relocation Kit")
events << Event.find_or_create_by_name("Emergency Contact Numbers")


event = events[0]
Task.find_or_create_by_custom_and_name_and_event_id(false, "Clean up all rubbish around the house, keep grass mown and whipper snipped, including nature strip. Move woodpile well away from house to southern fence boundary.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove all branches and overhanging the house. (Utilise Council's green waste service or vouchers.)", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Check all smoke alarms, and replace batteries if necessary.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Clean out all gutters, including sheds/garage. Check fire mesh over vents around the house.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Pack emergency kit in a large plastic container for quick transportation- photographs, backup discus, medications and prescriptions, insurance documents, passports, cameras, paintings, jewellery, etc. (see Emergency Kit section).", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Keep this kit in an accessible spot.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Keep mobile phones charged throughout the bushfire season and carry at all times. ", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify where we will go on a SEVERE, or greater, fire risk day.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Define responsibilities and make arrangements for all family and animals to be transported safely.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Practise our leave early plan with all the family. Make sure everyone knows their role and how scary a bushfire can be.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Discuss our fire plan with our direct neighbours, and exchange contact information to ensure we are all able to keep in touch in an emergency.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise the children's schools of our plans to leave early on a severe, or greater, fire risk day.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Place mops and metal buckets in an accessible location with the Emergency Kit", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Discuss with the entire family where we would shelter in the house if unable to leave (downstairs laundry - backing onto the south facing wall).", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Inform the Children that we will expect them to stay at school should a fire start during school hours, as both schools have fire protocols in place for emergencies.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Ensure all house entrance points are clear of all combustible items/materials for at least 10 metres. ", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Check hoses can be moved into the house, connect them to the washing machine taps and test they fit/connect.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "During bushfire season keep a close watch on the weather conditions.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Identify your trigger to leave. EG Total Fire Ban. Severe or Greater risk.", event.id)

event = events[1]
Task.find_or_create_by_custom_and_name_and_event_id(false, "Decide whether we will leave the night before or early the next morning (by 8.00am or earlier if Code Red, by 10.00am if Extreme, or by 11.00am if Severe warnings.)", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Move any outdoor furniture, other flammable items, doormats and items which may be dangerous in high winds into the garage, including BBQ gas bottle. ", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Divert the home phone to a mobile.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Take both cars, all family members, dogs, bird and our emergency kit and head for Auntie Elly's in Ringwood. Remain there until the danger has passed.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Prepare the family for a probably delay crossing the bridge at Warrandyte so as to avoid a panic.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "If a school day, notify the teachers our children will not be attending until further notices. (See Emergency contact numbers)", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Continually monitor 774 (ABC Radio) and CFA web site for emergency information", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Advise neighbours, Aunty Elly and close friends of our plans to leave early.", event.id)

event = events[2]
Task.find_or_create_by_custom_and_name_and_event_id(false, "Can we get to the Neighbourhood Safer Place - Warrandyte Reserve - LAST RESORT?? If not follow the steps below.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Place dogs and bird in the downstairs laundry area (southern rear wall with outdoor access) with water and food.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Block all down pipes with gutter plugs, tennis balls or rags and fill gutters with water.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Move cars into the garage and close the door.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Turn off Gas supply at main", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Divert home phone to Tom's mobile and carry mobile phone on a belt.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Remove from Emergency Kit, and everyone put on their fire protection clothing and gear, including masks. Hand out torches and fill and place metal buckets at front and back doors, with mops and wheelie bins filled with water.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Monitor 774 KHz. AM and cfa.vic.gov.au/incidents/incident_summary.htm on computer (assuming power is still available).", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Close all windows and doors (do not lock) and leave blinds up/. Turn off Air Conditioner.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Fill all baths and basins/sinks (upstairs and downstairs), and soak some towels, the towels to be used to seal under doors. Dry woollen blankets can cover the family in the event of the need to directly face the fire.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Alison, Sam and Mary to retreat to downstairs laundry with emergency kit and plenty of drinking water. Mary and Alison to look after Sam including breathing through a wet cloth to avoid smoke inhalation. Melissa to remain with June and Tom.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "June and Tom will ", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "(a) monitor for ember attack externally and", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "(b) later monitor upstairs and downstairs floors for fires.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Melissa to monitor inside until (b) occurs then act as a 'runner' for Tom and June inside the house (including providing them with plenty of drinking water).", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Place a ladder, torch and Supersoaker (water pistol) at the upstairs manhole to monitor roof space.", event.id)

event = events[3]
Task.find_or_create_by_custom_and_name_and_event_id(false, "Wet down all front and back decks and keep them wet.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Drench fire facing walls, and continually monitor for spot fires.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "When fire intensity becomes to great- retreat inside, move hoses into the house and connect them to the washing machine taps.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Tome and June continually patrol house/cielling with hoses to prevent internal fire.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Melissa to block under exterior doorways with wet towels and provide support to Tom and June. ", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Tom to check roof space regularly.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Alison and Mary put leads on the dogs.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "If the house catches fire move away from the source and shut doors behind us to isolate and slow down the burning parts of the house. The last room to retreat to must be the one with an exit (probably downstairs laundry). (Hopefully the fire front will have passed by the time we are forced into the downstairs laundry).", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "If the laundry is no longer safe move outside to the south side (back) of the house (against the brick wall) and cover each person with a dry woollen blankets and shelter here until the fire passes.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Try to manage the animals but do not let anyone go after them should they escape (stay together)", event.id)

event = events[4]
Task.find_or_create_by_custom_and_name_and_event_id(false, "Go around the house checking for embers and spot fires, and dousing these with the hose, mops and buckets etc.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Encourage everyone to keep drinking plenty of water.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "When all OK, call Aunty Elly and advise we are OK.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Check status of neighbours and street, including power lines, etc and report any problems via mobile phone to the CFA or Police.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Continue to monitor for spot fires.", event.id)

event = events[5]
Task.find_or_create_by_custom_and_name_and_event_id(false, "Large container with lid", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Photographs", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Back up discs and 2 TB backup drive", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Medications and prescriptions", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Important documents (insurance, passports, etc)", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Cameras, ", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Paintings", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Jewellery", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Address book and diary", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Mobile phone chargers", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Clothes for three days", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Toiletries", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Dog leads and food, bird seed and water", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Money", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Items of special value", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Nappies for Sam and Baby supplies (food, formula, snacks, medications, bottles etc)", event.id)

# event = Event.find_or_create_by_name '??'", event.id)
# NOTE: The following items are to protect the family and fight the fire in case we cannot leave early.", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Woollen Blankets", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Hard Hats", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Leather gloves", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "P2 Smoke masks", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Protective clothing (Long sleeved woollen shirts, jean, boots)", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Plenty of water and food for 3 days", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Battery operated radio", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Torches and spare batteries", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Supersoaker (Powerful Water Pistol)", event.id)

event = events[6]
Task.find_or_create_by_custom_and_name_and_event_id(false, "==Personal Contacts", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Aunty Ellie", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "1232132131", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "==Schools", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Andersons Creek Primary School", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Warrandyte High School", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "==Emergency Numbers", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Fire, Police, Ambulance", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "Warrandyte Police", event.id)
Task.find_or_create_by_custom_and_name_and_event_id(false, "==Close neighbours", event.id)


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

