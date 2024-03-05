# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
planets_name = %w[Mercury Venus Earth Mars Jupiter Saturn Uranus]
planets_description = [
  "The swifted planet.",
  "Earth's superhead twin sister.",
  "Our homeland.",
  "The red planet.",
  "King of the planets.",
  "Jewel of the solar system.",
  "The original ice giant."
]

planets_name.each_with_index do |planet_name, index|
  Planet.find_or_create_by!(name: planet_name, description: planets_description[index])
end

# Create a User
user1 = User.find_or_create_by!(email: 'laurent@hackers.com') do |user_create|
  user_create.password = 'password'
  user_create.first_name = 'Laurent'
  user_create.last_name = 'Lefebvre'
end
User.find_or_create_by!(email: 'declan@hackers.com') do |user_create|
  user_create.password = 'password'
  user_create.first_name = 'Declan'
  user_create.last_name = 'Schindler'
end
User.find_or_create_by!(email: 'yuefei@hackers.com') do |user_create|
  user_create.password = 'password'
  user_create.first_name = 'Yuefei'
  user_create.last_name = 'Dong'
end

# Assuming planets are already created
plots_name = %w[Crater Mountain LakeHouse Desert RainForest RockyArea Garden]
plots_description = [
  "A deep, bowl-shaped depression formed by meteorite or asteroid impacts.",
  "A large natural elevation of the earth's surface rising abruptly from the surrounding level.",
  "A serene house by the lake, ideal for relaxation.",
  "A barren, arid area of land with little to no vegetation.",
  "A dense forest that receives high amounts of rainfall.",
  "An area covered with rocky terrain, challenging for adventurers.",
  "A small piece of ground, planted with flowers, herbs, vegetables, or small fruits."
]

# Ensure we have the planets created
planets_name.each_with_index do |planet_name, index|
  Planet.find_or_create_by!(name: planet_name, description: planets_description[index])
end

# Now, associate plots with planets and the user
planets = Planet.all
plots_name.each_with_index do |plot_name, index|
  plot_description = plots_description[index]
  planet = planets[index % planets.size] # Cycle through planets

  # Create plots, associating them with a planet and the user
  Plot.find_or_create_by!(
    name: plot_name,
    description: plot_description,
    price: rand(1000.00..10_000.00).round(2),
    planet_id: planet.id,
    user: User.all.sample # Assign the created user's ID here
  )
end
