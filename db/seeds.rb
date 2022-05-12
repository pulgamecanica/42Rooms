# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

begin
	puts "Fetching 42Api..."
	client = OAuth2::Client.new(ENV['API_42_UID'], ENV['API_42_SECRET'], site: "https://api.intra.42.fr")
	token = client.client_credentials.get_token
	response = token.get("/v2/campus/")
	puts "Started Populating [all 42Campus]"
	if response.status.to_i == 200
		c_list = response.parsed
		c_list.each do |campus|
			c = Campus.new(name: campus["name"], country: campus["country"], language: campus["language"]["name"], address: campus["address"])
			c.save!
		end
		puts "Finished Populating, #{c_list.count} campuses created"
	else
		raise Exception.new "Status is different than 200"
	end
rescue Exception => e
	puts e.message
	puts "something went wrong... couldn't populate campus tables... :("
end
lisbon = Campus.find_by_name("Lisboa")
rooms_count = 5
if lisbon
	puts "Creating 42Lisboa Rooms"
	rooms_count.times do
		r = Room.new(
			name: Faker::Movies::HitchhikersGuideToTheGalaxy.unique.planet,
			description: Faker::Movies::HitchhikersGuideToTheGalaxy.unique.location,
			campus: lisbon,
			capacity: rand(4..10))
		r.save
	end
	puts "Finished, created #{rooms_count} rooms"
end