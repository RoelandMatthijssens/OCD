require 'faker'
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
#INSTITUTES
    vub = Institute.create!(
        :name => "Vrije Universiteit Brussel",
        :initials => "VUB",
        :location => "Brussel"
      )
    kul = Institute.create!(
        :name => "Katholieke Univeriteit Leuven",
        :initials => "KUL",
        :location => "Leuven"
      )
#FACULTIES
    Faculty.create!(
        :name => "Wetenschappen en Bio-ingenieurswetenschappen",
        :initials => "WE",
        :institute_id => vub.id
      )
    Faculty.create!(
        :name => "Letteren en Wijsbegeerte",
        :initials => "LEW",
        :institute_id => vub.id
      )
    Faculty.create!(
        :name => "Wetenschappen",
        :initials => "WE",
        :institute_id => kul.id
      )

    Discipline.create!(
        :name => "Computerwetenschappen",
        :initials => "CPUWET",
        :faculty_id => Faculty.first.id
      )
    Discipline.create!(
        :name => "Wiskunde",
        :initials => "WISK",
        :faculty_id => Faculty.first.id
      )
    permissionNames = [
      #admin permissions
      "use_control_panel", "sell_materials", "sell_all_materials", 'create_all_messages', 'view_all_stock', 'create_all_stock', 'view_all_orders',
      "print", "download_materials", "mark_order_as_payed", "can_view_side_supply", 'view_all_guilds' ,"set_order_status", "view_side_supply",
      "delete_all_supply","view_print_job_orders",
      #normal permissions
      "edit_users"              , "delete_users"              , "view_users"              ,
      "edit_permissions"        , "delete_permissions"        , "view_permissions"        , "create_permissions"        ,
      "edit_disciplines"        , "delete_disciplines"        , "view_disciplines"        , "create_disciplines"        ,
      "edit_subjects"           , "delete_subjects"           , "view_subjects"           , "create_subjects"           ,
      "edit_permission_groups"  , "delete_permission_groups"  , "view_permission_groups"  , "create_permission_groups"  ,
      "edit_options"            , "delete_options"            , "view_options"            , "create_options"            ,
      "edit_institutes"         , "delete_institutes"         , "view_institutes"         , "create_institutes"         ,
      "edit_guilds"             , "delete_guilds"             , "view_guilds"             , "create_guilds"             , "join_guilds",
      "edit_materials"          , "delete_materials"          , "view_materials"          , "create_materials"          ,
      "edit_faculties"          , "delete_faculties"          , "view_faculties"          , "create_faculties"          ,
      "edit_messages"           , "delete_messages"                                       , "create_messages"           ,
      "edit_stock"              , "delete_stock"              , "view_stock"              , "create_stock"              ,
      "edit_printers"           , "delete_printers"           , "view_printers"           , "create_printers"           ,
      "edit_prices"             , "delete_prices"             , "view_prices"             , "create_prices"             ,
      "edit_price_sets"         , "delete_price_sets"         , "view_price_sets"         , "create_price_sets"         ,
      "edit_action_logs"        , "delete_action_logs"        , "view_action_logs"        , "create_action_logs"        ,
      "edit_attachments"        , "delete_attachments"        , "view_attachments"        , "create_attachments"        ,
      "edit_info_strings"       , "delete_info_strings"       , "view_info_strings"       , "create_info_strings"       ,
      "edit_orders"             , "delete_orders"             , "view_orders"             , "create_orders"             ,
      "edit_print_jobs"         , "delete_print_jobs"         , "view_print_jobs"         , "create_print_jobs"         ,
      "edit_ratings"            , "delete_ratings"            , "view_ratings"            , "create_ratings"            ,
      "edit_supplies"           , "delete_supplies"           , "view_supplies"           , "create_supplies"           ,
      ]
      #"edit_"            , "delete_"           , "view_"           , "create_"           ,
    permissionNames.each do |name|
      PermissionGroup.create!(
        :name => name
      )
    end

    printerOptionNames = ["single sided - black and white",
      "Single sided - color",
      "Duplex - black and white",
      "Duplex - color",
      "Inbinding: Lijm + plastiek",
      "Inbinding: Lijm + zonder plastiek",
      "Inbinding: Ringen + plastiek",
      "Inbinding: Ringen + zonder plastiek"]
    printerOptionNames.each do |name|
      Option.create!(
        :name => name,
        :typee => 'printer'
      )
    end
    userOptionNames = ["1 slide per pagina", "3 slides per pagina"]
    userOptionNames.each do |name|
      Option.create!(
        :name => name,
        :typee => 'user'
      )
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

    infogroep = Guild.create!(
      :name => "InfoGroep",
      :initials => "IG",
      :disciplines => [Institute.first.faculties.first.disciplines.first]
    )
  end
end
