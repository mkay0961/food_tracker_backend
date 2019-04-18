require 'csv'
User.destroy_all
UserFood.destroy_all
Food.destroy_all
UserRecipe.destroy_all
Recipe.destroy_all
RecipeFood.destroy_all
puts "Destroyed all"

csv_text = File.read('/Users/MatthewKay/Development/Flatiron/Mod5/Food_Tracker/food_tracker_backend/db/Test3.csv')
csv = CSV.parse(csv_text, :headers => true)




puts "Done destroying, starting to seed"

for x in (0..csv.count) do
  if(csv[x].nil?)
    puts "y"
  else
    puts "FOOOOOOD"
    puts csv[x]["Name"]
    puts csv[x]["Image"].split("(")[1].split(")")[0]
    puts csv[x]["Categories"]
    puts csv[x]["Unit"]
    puts "FOOOOOOD"
    Food.find_or_create_by(name: csv[x]["Name"],
                           image: csv[x]["Image"].split("(")[1].split(")")[0],
                           category: csv[x]["Categories"] ,
                           default_expiration: Faker::Date.forward(130),
                           unit: csv[x]["Unit"])
  end

end


matthew = User.create(username: "mkay0961",
                      password: "123",
                      first_name: "Matthew",
                      last_name: "Kay",
                      email: "mkay0961@gmail.com",
                      profile_image: "https://media.licdn.com/dms/image/C5603AQHANqr1xr397g/profile-displayphoto-shrink_200_200/0?e=1560988800&v=beta&t=IKTdRqSV9InwuWjgJ1VCHjUHGeG2xMsPC1I0S6WQQlI")

80.times do
  f = Food.find(rand(1..Food.all.count))
  # puts "NON"
  # puts f
  # puts "#{rand(1..15)} #{f.unit}"
  # puts Faker::Date.forward(130)
  # puts "NON"
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
  # puts "EXP"
  # puts f
  # puts "#{rand(1..30)}.#{rand(1..99)}"
  # puts d
  # puts Faker::Date.between(d, Date.today)
  # puts "EXP"

  #
  userfood2 = UserFood.create(user_id: matthew.id,
                        food_id: f.id,
                        active: true,
                        amount: "#{rand(1..15)} #{f.unit}" ,
                        price: "#{rand(1..30)}.#{rand(1..99)}",
                        expiration_date: Faker::Date.between(d, Date.today),
                        created_at: d,
                        expired: true)
end

csv_text2 = File.read('/Users/MatthewKay/Development/Flatiron/Mod5/Food_Tracker/food_tracker_backend/db/recipes.csv')
csv2 = CSV.parse(csv_text2, :headers => true)


cat = ["Dinner", "Lunch", "Breakfast"]

100.times do
  recipe2 = Recipe.create(title: Faker::Food.dish,
                       description: Faker::Food.description,
                       instructions:csv2["Directions"][rand(0..csv2.count)],
                       category: cat[rand(0..cat.size-1)])
 rand(1..6).times do
  f = Food.find(rand(1..Food.all.count))
  rec2food1 = RecipeFood.create(recipe_id: recipe2.id,
                                food_id: f.id,
                                amount: "#{rand(1..5)} #{f.unit}")
  end

end

puts "Done seeding"
