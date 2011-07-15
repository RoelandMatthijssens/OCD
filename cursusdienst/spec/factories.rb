# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.full_name  'rik vanmechelen'
  user.rolno      90133
  user.user_name  'rivmeche'
  user.email      'name@mydomain.com'
end

Factory.define :institute do |institute|
  institute.name      'Vrije Universiteit Brussel'
  institute.initials  'VUB'
  institute.location  'Brussel'
end

Factory.define :faculty do |faculty|
  faculty.name        "Wetenschappen"
  faculty.initials    "WE"
  faculty.association :institute
end

Factory.define :discipline do |discipline|
  discipline.name         "Computer Wetenschappen"
  discipline.association  :faculty
end
