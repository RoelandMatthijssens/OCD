Factory.sequence(:user_id) { |n| n }
Factory.define :user do |user|
  user.after_build do |u|
    id = Factory.next :user_id
    u.full_name = "user_full_name #{id}"
    u.user_name = "user_user_name #{id}"
    u.email = "user_email #{id}"
  end
  user.association :permission_group
#  user.association :association
end

Factory.sequence(:permission_group_id) { |n| n }
Factory.define :permission_group do |permission_group|
  permission_group.after_build do |p|
    id = Factory.next :permission_group_id
    p.name = "permission_group_name #{id}"
    p.level = id
  end
end

Factory.sequence(:association_id) { |n| n }
Factory.define :association do |ass|
  ass.after_build do |p|
    id = Factory.next :association_id
    p.name = "association_name #{id}"
    p.initials = "association_initials #{id}"
  end
  ass.disciplines do |a|
    [a.association(:discipline)]
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

Factory.sequence(:faculty_id) { |n| n }
Factory.define :faculty do |faculty|
  faculty.after_build do |f|
    id = Factory.next :faculty_id
    f.name = "faculty_name #{id}"
    f.initials = "faculty_initials #{id}"
  end
  faculty.association :institute
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

Factory.sequence(:subject_id) { |n| n }
Factory.define :subject do |subject|
  subject.after_build do |s|
    id = Factory.next :subject_id
    s.name = "subject_name #{id}"
  end
end

Factory.define :teaching do |teaching|

end

Factory.sequence(:material_id) { |n| n }
Factory.define :material do |material|
  material.after_build do |m|
    id = Factory.next :material_id
    m.name = "material_name #{id}"
    m.nr = id
  end
  material.association :subject
end

Factory.sequence(:material_option_id) { |n| n }
Factory.define :material_option do |material_option|
  material_option.after_build do |m|
    id = Factory.next :material_option_id
    m.key = "material_key #{id}"
    m.value = "material_value #{id}"
  end
  material_option.association :material
end
