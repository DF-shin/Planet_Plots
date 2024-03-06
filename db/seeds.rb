# planets_name = %w[Mercury Venus Earth Mars Jupiter Saturn Uranus]
# planets_description = [
#   "The swifted planet.",
#   "Earth's superhead twin sister.",
#   "Our homeland.",
#   "The red planet.",
#   "King of the planets.",
#   "Jewel of the solar system.",
#   "The original ice giant."
# ]

# planets_name.each_with_index do |planet_name, index|
#   Planet.find_or_create_by!(name: planet_name, description: planets_description[index])
# end

# # Create a User
# user1 = User.find_or_create_by!(email: 'laurent@hackers.com') do |user_create|
#   user_create.password = 'password'
#   user_create.first_name = 'Laurent'
#   user_create.last_name = 'Lefebvre'
# end
# User.find_or_create_by!(email: 'declan@hackers.com') do |user_create|
#   user_create.password = 'password'
#   user_create.first_name = 'Declan'
#   user_create.last_name = 'Schindler'
# end
# User.find_or_create_by!(email: 'yuefei@hackers.com') do |user_create|
#   user_create.password = 'password'
#   user_create.first_name = 'Yuefei'
#   user_create.last_name = 'Dong'
# end

# # Assuming planets are already created
# plots_name = %w[Crater Mountain LakeHouse Desert RainForest RockyArea Garden]
# plots_description = [
#   "A deep, bowl-shaped depression formed by meteorite or asteroid impacts.",
#   "A large natural elevation of the earth's surface rising abruptly from the surrounding level.",
#   "A serene house by the lake, ideal for relaxation.",
#   "A barren, arid area of land with little to no vegetation.",
#   "A dense forest that receives high amounts of rainfall.",
#   "An area covered with rocky terrain, challenging for adventurers.",
#   "A small piece of ground, planted with flowers, herbs, vegetables, or small fruits."
# ]

# # Ensure we have the planets created
# planets_name.each_with_index do |planet_name, index|
#   Planet.find_or_create_by!(name: planet_name, description: planets_description[index])
# end

# # Now, associate plots with planets and the user
# planets = Planet.all
# plots_name.each_with_index do |plot_name, index|
#   plot_description = plots_description[index]
#   planet = planets[index % planets.size] # Cycle through planets

#   # Create plots, associating them with a planet and the user
#   Plot.find_or_create_by!(
#     name: plot_name,
#     description: plot_description,
#     price: rand(1000.00..10_000.00),
#     planet_id: planet.id,
#     user_id: user1.id # Assign the created user's ID here
#   )
# end




require 'net/http'
require 'uri'
require 'csv'
require 'json'

# Define the URL for the API request
uri = URI('https://exoplanetarchive.ipac.caltech.edu/TAP/sync?query=select+pl_name,discoverymethod,pl_orbper,pl_rade,pl_masse+from+ps&format=csv&where=pl_masse+is+not+null+and+pl_rade+is+not+null+limit+10')

# Perform the HTTP GET request
response = Net::HTTP.get_response(uri)

# Check if the request was successful
if response.is_a?(Net::HTTPSuccess)
  # Parse the CSV data
  csv = CSV.parse(response.body, headers: true)

  # Convert the CSV data into an array of hashes, filtering out rows with missing values
  exoplanets_data = csv.map do |row|
    {
      'pl_name' => row['pl_name'],
      'discoverymethod' => row['discoverymethod'],
      'pl_orbper' => row['pl_orbper'].to_f.round(2),
      'pl_rade' => row['pl_rade'].to_f.round(2),
      'pl_masse' => row['pl_masse'].to_f.round(2)
    }
  end

  # Process data to generate descriptions
  exoplanets_data.each do |planet|
    description = "#{planet['pl_name']} is an exoplanet discovered by the #{planet['discoverymethod']} method. "
    description += "It has an orbital period of #{planet['pl_orbper']} days, " if planet['pl_orbper'] != 0.0
    description += "a radius of #{planet['pl_rade']} Earth radii, " if planet['pl_rade'] != 0.0
    description += "and a mass of #{planet['pl_masse']} Earth masses. " if planet['pl_masse'] != 0.0
    planet['description'] = description
  end

  # exoplanets_data.each do |planet|
  #   description = "#{planet['pl_name']} is an exoplanet discovered by the #{planet['discoverymethod']} method. "
  #   description += "It has an orbital period of #{planet['pl_orbper']} days, " if planet['pl_orbper'] != 0.0
  #   description += "a radius of #{planet['pl_rade']} times that of Earth, " if planet['pl_rade'] != 0.0
  #   if planet['pl_masse'] && planet['pl_masse'] != 0.0
  #     description += "and a mass of #{planet['pl_masse']} times that of Earth. "
  #   else
  #     description += "and its mass is not precisely known. "
  #   end
  #   description += "It is located in the habitable zone of its star, where conditions might support liquid water." if planet['habitable'] == 'Yes'
  #   planet['description'] = description
  # end

  # Generate JSON file
  File.open('exoplanets.json', 'w') do |file|
    file.write(JSON.pretty_generate(exoplanets_data))
  end

  puts "JSON file 'exoplanets_descriptions.json' created successfully with descriptions for #{exoplanets_data.size} exoplanets."
else
  puts "Failed to fetch data: #{response.code} #{response.message}"
end
