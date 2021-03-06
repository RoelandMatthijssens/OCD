class Discipline < ActiveRecord::Base
  attr_accessible :name, :faculty_id, :associations, :subjects
  validates :name, :presence => true, :uniqueness => {:scope => :faculty_id}
  validates :faculty, :presence => true

  belongs_to :faculty
  has_and_belongs_to_many :guilds
  has_and_belongs_to_many :users
  has_many :teachings
  has_many :subjects, :through => :teachings

  default_scope :order => "disciplines.name ASC"
  scope :active, :conditions => {:deleted=>false}

  def full_name
    return "#{faculty.initials}-#{name}"
  end

  def institute
    faculty && faculty.institute
  end

  def institute_id
    faculty && faculty.institute.id
  end

end


# == Schema Information
#
# Table name: disciplines
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  faculty_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#
