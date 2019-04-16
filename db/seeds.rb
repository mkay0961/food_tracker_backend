require 'csv'
User.destroy_all
UserFood.destroy_all
Food.destroy_all
UserRecipe.destroy_all
Recipe.destroy_all
RecipeFood.destroy_all
puts "Destroyed all"

csv_text = File.read('/Users/MatthewKay/Development/Flatiron/Mod5/Food_Tracker/food_tracker_backend/db/Test.csv')
csv = CSV.parse(csv_text, :headers => true)




puts "Done destroying, starting to seed"

for x in (2...csv.count) do
  Food.find_or_create_by(name: csv[x]["Name"],
                         category: csv[x]["Categories"] ,
                         default_expiration: Faker::Date.forward(130),
                         unit: "oz")
end


matthew = User.create(username: "mkay0961",
                      password: "123",
                      first_name: "Matthew",
                      last_name: "Kay",
                      email: "mkay0961@gmail.com",
                      profile_image: "blank")

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


100.times do
  recipe2 = Recipe.create(title: Faker::Food.dish,
                       description: Faker::Food.description,
                       instructions:"1.Cut chicken 2.Cook chicken 1.Cut chicken 2.Cook chicken 1.Cut chicken 2.Cook chicken 1.Cut chicken 2.Cook chicken ",
                       category: "Dinner")
 rand(1..6).times do
  f = Food.find(rand(1..Food.all.count))
  rec2food1 = RecipeFood.create(recipe_id: recipe2.id,
                                food_id: f.id,
                                amount: "#{rand(1..5)} #{f.unit}")
  end

end

puts "Done seeding"
