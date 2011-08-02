require 'faker'
namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		User.create!(
				:name => "Roeland",
				:last_name => "Matthijssens",
				:email => "Fulgens.ailurus@gmail.com",
				:password => "roeland1",
				:password_confirmation => "roeland1",
				:user_name => "Enermis"
			)
		99.times do |n|
			password = "foobar"
			User.create!(
				:name => Faker::Name.first_name,
				:last_name => Faker::Name.last_name,
				:email => Faker::Internet.email,
				:password => password,
				:password_confirmation => password,
				:user_name => Faker::Internet.user_name
				)
		end
	end
end
