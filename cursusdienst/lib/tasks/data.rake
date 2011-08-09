require 'faker'
namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke

		Institute.create!(
				:name => "Vrije Universiteit Brussel",
				:initials => "VUB",
				:location => "Pleinlaan 2"
			)
		suffix = [ "Elementary", "Middel school", "College", "University", "High school" ]
		prefix = [ "Fort" ]
		10.times do |n|
			name = Faker::Name.name
			name = 'Saint '+name if rand(5) < 1
			if rand(10) < 9
				name+=' '+suffix[rand(suffix.length-1)]
			else
				name = prefix[rand(prefix.length-1)] + ' ' + name
			end
			initials = ''
			name.split(' ').each{|w| initials += w[0].capitalize}
			Institute.create!(
				:name => name,
				:initials => initials,
				:location => Faker::Address.street_address
			)
		end
		
		facultyNames = ["Recht en Criminologie", "Economische, Sociale en Politieke Wetenschappen", "Psychologie en Educatiewetenschappen",
			"Wetenschappen en Bio-ingenieurswetenschappen", "Geneeskunde en Farmacie", "Letteren en Wijsbegeerte", "Ingenieurswetenschappen",
			"Lichamelijke Opvoeding en Kinesitherapie", "Interfacultair Departement Lerarenopleiding"]
		Institute.all.each do |institute|
			rand(facultyNames.length).times do
				name = facultyNames[rand(facultyNames.length-1)]
				initials = ''
				name.split(' ').each{|w| initials += w[0].capitalize}
				f = Faculty.new(
					:name => name,
					:initials => initials
				)
				f.institute = institute
				f.save if f.valid?
			 end
		 end
		
		Faculty.all.each do |faculty|
			rand(5).times do 
				d = Discipline.new(
					:name => Faker::Lorem.words(1)
					)
				d.faculty = faculty
				d.save if d.valid?
			end
		end
		
		Discipline.all.each do |discipline|
			rand(6).times do
				s = Subject.new(
					:name => Faker::Lorem.words(1)
					)
				s.disciplines << discipline
				s.save if s.valid?
			 end
		 end
		
		permissionNames = ["use_control_panel",
			"edit_users",				"delete_users",				"view_users"				,	
			"edit_permissions",	"delete_permissions",	"view_permissions"	,	"create_permissions"	,
			"edit_disciplines",	"delete_disciplines",	"view_disciplines"	,	"create_disciplines"	,
			"edit_subjects"		,	"delete_subjects"		,	"view_subjects"			,	"create_subjects"			,]
		permissionNames.each do |name|
			PermissionGroup.create!(
				:name => name
			)
		end
		
		optionNames = ["recto_verso", "2_slides_per_page", "4_slides_per_page", "6_slides_per_page", "custom_cover"]
		optionNames.each do |name|
			Option.create!(
				:name => name
				)
		 end
		
		Subject.all.each do |subject|
			materialNames = ["Boek", "Slides", "Samenvatting", "Cursusnotas"]
			rand(3).times do
				name = materialNames[rand(materialNames.length - 1)]
				m = Material.new(
					:name => name
					)
				m.subject = subject
				rand(3).times do |n|
					nn = rand(Option.all.size)+1
					o = Option.find(nn) unless nn == 0
					m.options << o
				end
				m.save if m.valid?
			end
		end
		
		enermis = User.create!(
				:name => "Roeland",
				:last_name => "Matthijssens",
				:email => "Fulgens.ailurus@gmail.com",
				:password => "roeland1",
				:password_confirmation => "roeland1",
				:user_name => "Enermis"
			)
		rik = User.create!(
				:name => "Rik",
				:last_name => "Vanmechelen",
				:email => "rik.vanmechelen@gmail.com",
				:password => "roeland1",
				:password_confirmation => "roeland1",
				:user_name => "rik"
			)
		[enermis, rik].each { |u| u.permission_groups << PermissionGroup.all}
		99.times do |n|
			password = "foobar"
			u = User.new(
				:name => Faker::Name.first_name,
				:last_name => Faker::Name.last_name,
				:email => Faker::Internet.email,
				:password => password,
				:password_confirmation => password,
				:user_name => Faker::Internet.user_name
				)
			u.save if u.valid?
		end
	end
end
