# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Destroying all"

User.destroy_all
UserFood.destroy_all
Food.destroy_all
UserRecipe.destroy_all
Recipe.destroy_all
RecipeFood.destroy_all

puts "Done destroying, starting to seed"

matthew = User.create(username: "mkay0961",
                      password: "123",
                      first_name: "Matthew",
                      last_name: "Kay",
                      email: "mkay0961@gmail.com",
                      profile_image: "blank")

mango = Food.create(name: "Mango",
                    category: "Produce" ,
                    default_expiration: "07/25/2020" )

spinach = Food.create(name: "Spinach",
                      category: "Produce" ,
                      default_expiration: "07/25/2020" )

bbqsauce = Food.create(name: "BBQ Sauce",
                      category: "Pantry" ,
                      default_expiration: "07/25/2020" )


chicken = Food.create(name: "Chicken",
                      category: "Poutry" ,
                      default_expiration: "07/25/2020" )


limes = Food.create(name: "Limes",
                    category: "Produce" ,
                    default_expiration: "07/25/2020" )





userfood1 = UserFood.create(user_id: matthew.id,
                         food_id: mango.id,
                         active: true,
                         amount: "",
                         price: 2.00,
                         expiration_date: "04/4/2019",
                         expired: false)

userfood2 = UserFood.create(user_id: matthew.id,
                        food_id: spinach.id,
                        active: true,
                        amount: "",
                        price: 5.00,
                        expiration_date: "04/4/2019",
                        expired: false)

userfood3 = UserFood.create(user_id: matthew.id,
                        food_id: chicken.id,
                        active: true,
                        amount: "",
                        price: 10.00,
                        expiration_date: "04/4/2019",
                        expired: false)

recipe1 = Recipe.create(title: "BBQ Chicken",
                       description: "Amazing chicken dish",
                       instructions:"1.Cut chicken 2.Cook chicken",
                       category: "Dinner")

rec1food1 = RecipeFood.create(recipe_id: recipe1.id,
                              food_id: bbqsauce.id,
                              amount: "1 oz")

rec1food2 = RecipeFood.create(recipe_id: recipe1.id,
                              food_id: chicken.id,
                              amount: "1 pound")

recipe2 = Recipe.create(title: "Mango Chicken",
                       description: "Amazing chicken dish",
                       instructions:"1.Cut chicken 2.Cook chicken",
                       category: "Dinner")

rec2food1 = RecipeFood.create(recipe_id: recipe2.id,
                              food_id: mango.id,
                              amount: "2")

rec2food2 = RecipeFood.create(recipe_id: recipe2.id,
                              food_id: chicken.id,
                              amount: "1 pound")


userRecipe = UserRecipe.create(user_id: matthew.id,
                               recipe_id: recipe2.id,
                               mine: false)

puts "Done seeding"
