# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Request.create(name: "applesauce", quantity: 2)
Request.create(name: "canned beans", quantity: 3)
Request.create(name: "canned fish", quantity: 4)
Request.create(name: "canned meat", quantity: 1)
Request.create(name: "canned vegetables")
Request.create(name: "cooking oils")
Request.create(name: "crakers")
Request.create(name: "dried herbs and spices")

User.create(name: "Michael", password_digest: "help!")
User.create(name: "Henry", password_digest: "Baratheon")
User.create(name: "Wilma", password_digest: "St. George")