# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.delete_all
Task.delete_all
Person.delete_all


Event.create(id: 300, name: 'Approaching Fire', priority: 1)
Task.create(id: 10, name: 'Fill the gutters with water', event_id: 300)
Person.create(id: 1, name: 'Julian', email: 'jkelabora@dius.com.au', task_id: 10)


Event.create(id: 500, name: 'Gale Force Winds', priority: 2)
Task.create(id: 20, name: 'Secure loose items outside', event_id: 500)
Person.create(id: 2, name: 'Frank', email: 'randombloke95@gmail.com', task_id: 20)
