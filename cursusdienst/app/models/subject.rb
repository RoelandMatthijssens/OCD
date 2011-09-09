class Subject < ActiveRecord::Base
  attr_accessible :name, :materials, :year, :year_type
  validates :name, :presence => true
  validates :year, :presence => true
  validates :year_type, :presence => true
  has_many :teachings
  has_many :disciplines, :through => :teachings
  has_many :materials
  default_scope :order => "subjects.name ASC"
  validates_associated :teachings
  validate :unique_name_per_institute

  accepts_nested_attributes_for :disciplines
  
  def subjects(i)
    result = []
    i.faculties.each { |x| x.disciplines.each{ |x| x.subjects.each { |x| result << x }}}
    return result
  end
  
  def unique_name_per_institute
    disciplines.each do |discipline|
      institute = discipline.faculty.institute
      s = subjects(institute)
      s.each do |sub|
        errors.add(:subject, "needs unique name per institute") if
          sub.name == name && sub.id != id
      end
    end
  end
  
end

# == Schema Information
#
# Table name: subjects
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

