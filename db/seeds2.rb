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
    description += "It has an orbital period of #{planet['pl_orbper']} days, "
    description += "a radius of #{planet['pl_rade']} Earth radii, "
    description += "and a mass of #{planet['pl_masse']} Earth masses. "
    planet['description'] = description
  end

  # Generate JSON file
  File.open('exoplanets_descriptions.json', 'w') do |file|
    file.write(JSON.pretty_generate(exoplanets_data))
  end

  puts "JSON file 'exoplanets_descriptions.json' created successfully with descriptions for #{exoplanets_data.size} exoplanets."
else
  puts "Failed to fetch data: #{response.code} #{response.message}"
end
