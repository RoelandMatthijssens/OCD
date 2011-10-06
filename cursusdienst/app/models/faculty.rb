#      t.string :name

class Faculty < ActiveRecord::Base
  attr_accessible :name, :initials, :full_name, :institute_id
  validates :name, :presence => true, :uniqueness => {:scope => :institute_id}
  validates :initials, :presence => true, :uniqueness => {:scope => :institute_id}
  validates :institute, :presence => true
  has_many :disciplines, :dependent => :destroy
  belongs_to :institute


  default_scope :order => "faculties.name ASC"
  scope :active, :conditions => {:deleted=>false}

  def full_name
    "#{institute.initials}: #{name}"
  end
end

# == Schema Information
#
# Table name: faculties
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  institute_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  initials     :string(255)
#
