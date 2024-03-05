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
planets_description = ["The swifted planet.", "Earth's superhead twin sister.", "Our homeland.", "The red planet.", "King of the planets.", "Jewel of the solar system.", "The original ice giant."]

planets_name.each_with_index do |planet_name, index|
  Planet.create!(name: planet_name, description: planets_description[index])
end
