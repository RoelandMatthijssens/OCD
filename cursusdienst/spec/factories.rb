# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.full_name  'rik vanmechelen'
  user.rolno      90133
  user.user_name  'rivmeche'
  user.email      'name@mydomain.com'
end

Factory.sequence(:institute_id) { |n| n }
Factory.define :institute do |institute|
  institute.after_build do |i|
    id = Factory.next :institute_id
    i.name = "institute_name #{id}"
    i.initials = "institute_initials #{id}"
    i.location = "institute_location #{id}"
  end
end

Factory.sequence(:faculty_id) { |n| n }
Factory.define :faculty do |faculty|
  faculty.association :institute
  faculty.after_build do |f|
    id = Factory.next :faculty_id
    f.name = "faculty_name #{id}"
    f.initials = "faculty_initials #{id}"
  end
end

Factory.sequence(:discipline_id) { |n| n }
Factory.define :discipline do |discipline|
  discipline.after_build do |d|
    id = Factory.next :discipline_id
    d.name = "discipline_name #{id}"
  end
  discipline.association  :faculty
end

Factory.sequence(:subject_id) { |n| n }
Factory.define :subject do |subject|
  subject.after_build do |s|
    id = Factory.next :subject_id
    s.name = "subject_name #{id}"
  end
  subject.disciplines do |su|
    [su.association(:discipline)]
  end
end

Factory.define :discipline do |discipline|
  discipline.name  "Computer Science"
  discipline.association :faculty
end
