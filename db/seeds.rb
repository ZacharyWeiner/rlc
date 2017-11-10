# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


adventure = Category.create!(name: "Adventure")
family = Category.create!(name: "Family")
foodie = Category.create!(name: "Foodie")
artistic  = Category.create!(name: "Artistic")
adult = Category.create!(name: "Adult")


bkb = Location.create!(name: 'Butcher Knife Brewery', address: '2875 Elk River Road, Steamboat Springs, CO 80487')
spb = Location.create!(name: 'Storm Peak Brewery', address: '1885 Elk River Plaza, Steamboat Springs, CO 80487')
smtb = Location.create!(name: 'Smell That Bread Bakery', address: '135 11th St, Steamboat Springs, CO 80487')
pw = Location.create!(name: 'Potters Wheel Studio', address: '1280 13th St k, Steamboat Springs, CO 80487')
ohanas = Location.create!(name: 'Ohanas Factory', address: '700 Yampa St a105, Steamboat Springs, CO 80487')
wwb = Location.create!(name: 'Wild West Baloons HQ', address: '953 Dougherty Rd, Steamboat Springs, CO 80487')
gondola = Location.create!(name: 'Steamboat Gondola', address: '2305 Mt Werner Cir #1, Steamboat Springs, CO 80487')


Business.create!(name: "Butcher Knife Brewery", location: bkb, category_id: adult.id, contact_name: "", contact_phone: "", business_type: "Brewery")
Business.create!(name: "Storm Peak Brewery", location: spb, category_id: adult.id, contact_name: "", contact_phone: "", business_type: "Brewery")
Business.create!(name: "Smell That Bread", location: smtb, category_id: foodie.id, contact_name: "", contact_phone: "", business_type: "Bakery")
Business.create!(name: "The Potters Wheel", location: pw, category_id: artistic.id, contact_name: "", contact_phone: "", business_type: "Art Studio")
Business.create!(name: "Ohanas", location: ohanas, category_id: artistic.id, contact_name: "", contact_phone: "", business_type: "T Shirt Printing")
Business.create!(name: "Wild West Balloons", location: wwb, category_id: adventure.id, contact_name: "", contact_phone: "", business_type: "Hot Air Baloon Rides")
Business.create!(name: "Steamboat Gondola", location: gondola, category_id: family.id, contact_name: "", contact_phone: "", business_type: "Gondola Rides")






