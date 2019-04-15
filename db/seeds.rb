require 'csv'
User.destroy_all
UserFood.destroy_all
Food.destroy_all
UserRecipe.destroy_all
Recipe.destroy_all
RecipeFood.destroy_all



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

csv_text = File.read('/Users/MatthewKay/Development/Flatiron/Mod5/Food_Tracker/food_tracker_backend/db/Test.csv')
csv = CSV.parse(csv_text, :headers => true)

# puts csv.count
# file = File.read("/Users/MatthewKay/Development/Flatiron/Mod5/Food_Tracker/food_tracker_backend/db/file1.json")
# data = JSON.parse(file)
# data.keys.each_with_index { |chr, x|
#   puts data[chr]["title"]
# }Date.parse('3rd Feb 2001')

puts "Destroyed all"


puts "Done destroying, starting to seed"

for x in (2...csv.count) do
  Food.find_or_create_by(name: csv[x]["Name"],
                         category: csv[x]["Categories"] ,
                         default_expiration: Faker::Date.forward(130),
                         unit: "oz")
end
#
puts "hu"
# dish = Faker::Food
# puts dish.dish
# puts dish.description
# puts dish.ingredient
# #
# recipe2 = Recipe.create(title: "Mango Chicken",
#                        description: "Amazing chicken dish",
#                        instructions:"1.Cut chicken 2.Cook chicken",
#                        category: "Dinner")

# puts Faker::Food.description #=> "Three eggs with cilantro, tomatoes, onions, avocados and melted Emmental cheese. With a side of roasted potatoes, and your choice of toast or croissant."
#
# Faker::Food.dish #=> "Caesar Salad"
#
# Faker::Food.fruits #=> "Peaches"
#
# Faker::Food.ingredient

matthew = User.create(username: "mkay0961",
                      password: "123",
                      first_name: "Matthew",
                      last_name: "Kay",
                      email: "mkay0961@gmail.com",
                      profile_image: "blank")
puts "hu"
# mango = Food.create(name: "Mango",
#                     category: "Produce" ,
#                     default_expiration: "2020-4-4",
#                     unit: "mango" )
#
# spinach = Food.create(name: "Spinach",
#                       category: "Produce" ,
#                       default_expiration: "2020-4-4",
#                       unit: "cup" )
#
# bbqsauce = Food.create(name: "BBQ Sauce",
#                       category: "Pantry" ,
#                       default_expiration: "2020-4-4",
#                       unit: "cup" )
# puts "hu"
#
# chicken = Food.create(name: "Chicken",
#                       category: "Poutry" ,
#                       default_expiration: "2020-4-4",
#                       unit: "pound" )
#
#
# limes = Food.create(name: "Limes",
#                     category: "Produce" ,
#                     default_expiration: "2020-4-4",
#                     unit: "lime" )
#
#
# puts "hu"
#
#
# userfood1 = UserFood.create(user_id: matthew.id,
#                          food_id: mango.id,
#                          active: false,
#                          amount: "1 mango",
#                          price: 2.00,
#                          expiration_date: "2019-2-4",
#                          throw_away: "2019-2-6",
#                          created_at: "2019-2-1",
#                          expired: true)
#
# userfood2 = UserFood.create(user_id: matthew.id,
#                         food_id: spinach.id,
#                         active: true,
#                         amount: "2 cup",
#                         price: 5.00,
#                         expiration_date: DateTime.now,
#                         expired: false)
# # 500.times do
# userfood2 = UserFood.create(user_id: matthew.id,
#                         food_id: spinach.id,
#                         active: true,
#                         amount: "2 cup",
#                         price: 5.00,
#                         expiration_date: DateTime.now,
#                         expired: false)
# end
80.times do
  f = Food.find(rand(1..Food.all.count))
userfood2 = UserFood.create(user_id: matthew.id,
                        food_id: f.id,
                        active: true,
                        amount: "#{rand(1..15)} #{f.unit}" ,
                        price: "#{rand(1..30)}.#{rand(1..99)}",
                        expiration_date: Faker::Date.forward(130),
                        expired: false)
end

20.times do
  f = Food.find(rand(1..Food.all.count))

d = Faker::Date.backward(90)
userfood2 = UserFood.create(user_id: matthew.id,
                        food_id: f.id,
                        active: true,
                        amount: "#{rand(1..15)} #{f.unit}" ,
                        price: "#{rand(1..30)}.#{rand(1..99)}",
                        expiration_date: Faker::Date.between(d, Date.today),
                        created_at: d,
                        expired: false)
end























# userfood3 = UserFood.create(user_id: matthew.id,
#                         food_id: chicken.id,
#                         active: true,
#                         amount: "1 pound",
#                         price: 10.00,
#                         expiration_date: "2019-3-4",
#                         created_at: "2019-3-1",
#                         expired: false)
# puts "hu"
# userfood3 = UserFood.create(user_id: matthew.id,
#                         food_id: chicken.id,
#                         active: true,
#                         amount: "6 pound",
#                         price: 13.00,
#                         expiration_date: DateTime.now,
#                         expired: false)
#
# recipe1 = Recipe.create(title: "BBQ Chicken",
#                        description: "Amazing chicken dish",
#                        instructions:"1.Cut chicken 2.Cook chicken",
#                        category: "Dinner")
#
#
# rec1food1 = RecipeFood.create(recipe_id: recipe1.id,
#                               food_id: bbqsauce.id,
#                               amount: "1 cup")
#
# rec1food2 = RecipeFood.create(recipe_id: recipe1.id,
#                               food_id: chicken.id,
#                               amount: "1 pound")
100.times do
recipe2 = Recipe.create(title: Faker::Food.dish,
                       description: Faker::Food.description,
                       instructions:"1.Cut chicken 2.Cook chicken 1.Cut chicken 2.Cook chicken 1.Cut chicken 2.Cook chicken 1.Cut chicken 2.Cook chicken ",
                       category: "Dinner")
 rand(1..6).times do
   puts recipe2.id
   puts Food.find(rand(1..Food.all.count)).id
   puts rand(1..6)
   f = Food.find(rand(1..Food.all.count))
  rec2food1 = RecipeFood.create(recipe_id: recipe2.id,
                                food_id: f.id,
                                amount: "#{rand(1..5)} #{f.unit}")
puts "xs"
#
end
# # rec2food1 = RecipeFood.create(recipe_id: recipe2.id,
#                               food_id: mango.id,
#                               amount: "2 mango")
#
# rec2food2 = RecipeFood.create(recipe_id: recipe2.id,
#                               food_id: chicken.id,
#                               amount: "1 pound")

end
# userRecipe = UserRecipe.create(user_id: matthew.id,
#                                recipe_id: recipe1.id,
#                                mine: false)

puts "Done seeding"
