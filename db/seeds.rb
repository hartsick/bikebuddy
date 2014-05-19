# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# WORK IN PROGRESS

users = User.create([
	{username: "hartsick", name: "Christa", email:"christa.hartsock@gmail.com", time_zone: "EST", password_digest: "$2a$10$BZIk5F2jBJoIAXm.lJZMTezFnwspfvlXKaKNC2OvL0sPtFQ4IER76", phone: "4199969846"},
	{username: "jimmytheleaf", name: "Jim", email:"jim.fingal@gmail.com", time_zone: "PST", password_digest: "$2a$10$BZIk5F2jBJoIAXm.lJZMTezFnwspfvlXKaKNC2OvL0sPtFQ4IER76", phone: "7143173140"},
	{username: "master", name: "master", email:"master@master", time_zone: "PST", password_digest: "$2a$10$BZIk5F2jBJoIAXm.lJZMTezFnwspfvlXKaKNC2OvL0sPtFQ4IER76", phone: "master"}
	])
routes = Route.create([
	{name: "Hollywood to GA", route_start: "1726 N Gramercy Pl Los Angeles, CA", route_end: "1520 2nd St Santa Monica, CA", user: users.first},
	{name: "KTown to Downtown", route_start: "3317 W 6th St Los Angeles, CA", route_end: "453 S Spring St Los Angeles, CA", user: users[1]},
	{name: "Westwood to Venice", route_start: "UCLA", route_end: "Dogtown Coffee Venice, CA", users[2]}
	])
rides = Ride.create([
	{name: "Midnight Ridazz", difficulty: "Hard", start_time_hour: 11, start_time_min: 45, start_time_am: "PM", frequency: "Wednesdays", ride_admin: users[2], ride_creator: user[2], users: [users.first, users[1], users[2]], route: routes.first },
	{name: "Donut Friends", difficulty: "Hard", start_time_hour: 7, start_time_min: 00, start_time_am: "PM", frequency: "Weekdays", ride_admin: users[1], ride_creator: user[1], users: [users[2], route: routes[1]] },
	{name: "Hollywood Hackers", difficulty: "Easy", start_time_hour: 9, start_time_min: 00, start_time_am: "AM", frequency: "Weekdays", ride_admin: users[2], ride_creator: user[2], users: [users.first, users[2]], route: routes.first },
	{name: "Hollywood Hackers", difficulty: "Easy", start_time_hour: 9, start_time_min: 00, start_time_am: "AM", frequency: "Weekdays", ride_admin: users[2], ride_creator: user[2], users: [users.first, users[2]], route: routes.first },
	])