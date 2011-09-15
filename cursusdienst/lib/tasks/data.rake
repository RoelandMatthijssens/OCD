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
    #suffix = [ "Elementary", "Middel school", "College", "University", "High school" ]
    #prefix = [ "Fort" ]
    #2.times do |n|
      #name = Faker::Name.name
      ##name = 'Saint '+name if rand(5) < 1
      ##if rand(10) < 9
        ##name+=' '+suffix[rand(suffix.length-1)]
      ##else
        ##name = prefix[rand(prefix.length-1)] + ' ' + name
      ##end
      #initials = ''
      #name.split(' ').each{|w| initials += w[0].capitalize}
      #Institute.create!(
        #:name => name,
        #:initials => initials,
        #:location => Faker::Address.street_address
      #)
    #end

    facultyNames = ["Recht en Criminologie", "Psychologie en Educatiewetenschappen",
      "Wetenschappen en Bio-ingenieurswetenschappen"]
    Institute.all.each do |institute|
      facultyNames.each do |name|
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
      id = 0
      3.times do
        d = Discipline.new(
          :name => id.to_s+" discipline"
          )
        id += 1
        d.faculty = faculty
        d.save if d.valid?
      end
    end

    Discipline.all.each do |discipline|
      id = 0
      3.times do
        s = Subject.new(
          :name => discipline.faculty.institute.initials + " - " + discipline.faculty.initials + " - " + discipline.name + " - " + id.to_s+" subject",
          :year => 1,#rand(3)+1,
          :year_type => ['bachelor', 'master'][1],#[rand(2)],
          )
        id += 1
        s.disciplines << discipline
        s.save if s.valid?
       end
     end
    #xxx_all_yyy is used when general permissions are only applicable for specific instances of yyy
    #e.g. sell_materials => users can only mark materials as sellable for their own guild
         #sell_all_materials => the user can mark materials as sellable for any guild.. even if he is not a member of it.
    permissionNames = [
      #admin permissions
      "use_control_panel", "sell_materials", "sell_all_materials", 'create_all_messages', 'view_all_stock', 'view_all_orders',
      "print",
      #normal permissions
      "edit_users"              , "delete_users"              , "view_users"              ,
      "edit_permissions"        , "delete_permissions"        , "view_permissions"        , "create_permissions"        ,
      "edit_disciplines"        , "delete_disciplines"        , "view_disciplines"        , "create_disciplines"        ,
      "edit_subjects"           , "delete_subjects"           , "view_subjects"           , "create_subjects"           ,
      "edit_permission_groups"  , "delete_permission_groups"  , "view_permission_groups"  , "create_permission_groups"  ,
      "edit_options"            , "delete_options"            , "view_options"            , "create_options"            ,
      "edit_institutes"         , "delete_institutes"         , "view_institutes"         , "create_institutes"         ,
      "edit_guilds"             , "delete_guilds"             , "view_guilds"             , "create_guilds"             ,
      "edit_materials"          , "delete_materials"          , "view_materials"          , "create_materials"          ,
      "edit_faculties"          , "delete_faculties"          , "view_faculties"          , "create_faculties"          ,
      "edit_messages"           , "delete_messages"                                       , "create_messages"           ,
      "edit_stock"              , "delete_stock"              , "view_stock"                                            ,
      ]
      #"edit_"            , "delete_"           , "view_"           , "create_"           ,
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
      1.times do
        materialNames.each do |name|
          m = Material.new(
            :name => name,
            :price => rand(20)
            )
          m.subject = subject
          #rand(3).times do |n|
            #nn = rand(Option.all.size)+1
            #o = Option.find(nn) unless nn == 0
            #m.options << o
          #end
          m.save if m.valid?
        end
      end
    end

    enermis = User.create!(
      :name => "Roeland",
      :last_name => "Matthijssens",
      :email => "fulgens.ailurus@gmail.com",
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
    tyca = User.create!(
      :name => "Tyca",
      :last_name => "Tyca",
      :email => "Tyca@tyca.com",
      :password => "apuapu",
      :password_confirmation => "apuapu",
      :user_name => "Tyca"
      )
    test = User.create!(
      :name => "Test",
      :last_name => "Test",
      :email => "Test@gmail.com",
      :password => "roeland1",
      :password_confirmation => "roeland1",
      :user_name => "test"
    )
    [enermis, rik, tyca].each { |u| u.permission_groups << PermissionGroup.all}
    #18.times do |n|
      #password = "foobar"
      #u = User.new(
        #:name => Faker::Name.first_name,
        #:last_name => Faker::Name.last_name,
        #:email => Faker::Internet.email,
        #:password => password,
        #:password_confirmation => password,
        #:user_name => Faker::Internet.user_name
        #)
      #u.save if u.valid?
    #end

    infogroep = Guild.create!(
      :name => "InfoGroep",
      :initials => "IG",
      :disciplines => [Institute.first.faculties.first.disciplines.first]
    )

    User.all.each { |u| u.guilds <<  infogroep}

    x = Guild.first
    x.disciplines.each do |discipline|
      discipline.subjects.each do |subject|
          x.materials << subject.materials
      end
    end

    infogroep.materials.each do |m|
      x = Stock.new(
        :material => m,
        :guild => infogroep,
        :amount => 1,
        :threshold => 2,
        :step => 3,
        :typee => 'JIT',
        :floating => 4,
        :floating_period => 5
      )
      x.save!
    end
  end
end
