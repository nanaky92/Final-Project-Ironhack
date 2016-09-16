# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

groups = Group.create([{name:"Mi comunidad"}, {name:"Ironhack"}])
users = User.create([{name: "User1", password: "pass1", email: "1@gmail.com"}, 
  {name: "User2", password: "pass2", email: "2@gmail.com"}, 
  {name: "User3", password: "pass3", email: "3@gmail.com"}]);