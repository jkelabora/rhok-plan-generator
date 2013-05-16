
Event.delete_all
Task.delete_all
Person.delete_all

Event.new(name: 'To Do - Before the bushfire season', priority: 10).save!
Event.new(name: 'To Do - During the bushfire season', priority: 20).save!
Event.new(name: 'Night before you evacuate/defend', priority: 30).save!
Event.new(name: 'Doing', priority: 40).save!
Event.new(name: 'Done', priority: 50).save!

event = Event.find_by_name('To Do - Before the bushfire season')
Task.new(name: 'Clear fine fuels around the house/property - weeds, leaf litter, dead branches (smaller than diameter of a pencil).', event_id: event.id).save!
Task.new(name: 'Trim tree branches overhanging the house.', event_id: event.id).save!
Task.new(name: 'Trim shrubs around the house - no shrubs over 1 metre.', event_id: event.id).save!
Task.new(name: 'Clear gutters.', event_id: event.id).save!
Task.new(name: 'Cover air vents with fine metal mesh.', event_id: event.id).save!
Task.new(name: 'Check hose fittings are in good working order.', event_id: event.id).save!
Task.new(name: 'Check hoses reach entire house.', event_id: event.id).save!
Task.new(name: 'Prepare emergency stay/go kit.', event_id: event.id).save!
Task.new(name: 'Place emergency stay/go kit in an easy accessible location.', event_id: event.id).save!
Task.new(name: 'Move firewood away from the house.', event_id: event.id).save!
Task.new(name: 'Move any flammable items away from the house.', event_id: event.id).save!
Task.new(name: 'Back up computer files onto external hard drive.', event_id: event.id).save!
Task.new(name: 'Know where metal buckets, mops, rakes, etc are located.', event_id: event.id).save!
Task.new(name: 'Prepare relocation kit.', event_id: event.id).save!

event = Event.find_by_name('To Do - During the bushfire season')
Task.new(name: 'Fill external water sources - eg. wheelie bins with lids.', event_id: event.id).save!
Task.new(name: 'Maintain fine fuels around the house.', event_id: event.id).save!
Task.new(name: 'Keep gutters clear.', event_id: event.id).save!
Task.new(name: 'Know where metal buckets, mops, rakes, etc are located.', event_id: event.id).save!
Task.new(name: 'Know where boots are for all household members.', event_id: event.id).save!
Task.new(name: 'Practice moving through the house in full protective gear in the complete dark.', event_id: event.id).save!
Task.new(name: 'Find somewhere safe to put photos, scrapbooks, documents (birth certificates, insurance docs & receipts, passports).', event_id: event.id).save!

event = Event.find_by_name('Night before you evacuate/defend')
Task.new(name: 'Listen to ABC 774 for updates on fire conditions.', event_id: event.id).save!
Task.new(name: 'Check warrandyte.org.au Real Time Info page regularly for updates on fire & weather conditions.', event_id: event.id).save!
Task.new(name: 'Charge mobile phones and i-pods.', event_id: event.id).save!
Task.new(name: 'Check emergency stay/go kit is complete.', event_id: event.id).save!
Task.new(name: 'Move door mats and other loose flammable items inside or away from the house.', event_id: event.id).save!
Task.new(name: 'Put emergency stay/go kit in car or near the front door.', event_id: event.id).save!
