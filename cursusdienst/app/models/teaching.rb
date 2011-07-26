class Teaching < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :subject
  validate :unique_name_per_institute
  
  def subjects(i)
    result = []
    i.faculties.each { |x| x.disciplines.each{ |x| x.subjects.each { |x| result << x }}}
    return result
  end
  
  def unique_name_per_institute
    name = subject.name
    institute = discipline.faculty.institute
    s = subjects(institute)
    s.each do |sub|
      errors.add(:subject, "needs unique name per institute") if
        sub.name == name
    end
  end
end

# == Schema Information
#
# Table name: teachings
#
#  id            :integer(4)      not null, primary key
#  discipline_id :integer(4)
#  subject_id    :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#
