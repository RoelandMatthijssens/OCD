class Material < ActiveRecord::Base
  attr_accessible :name, :subject_id, :guilds, :material_options, :parent_id, :path_name
  validates :name, :presence => true
  #validates :nr, :presence => true
  belongs_to :subject
  belongs_to :parent, :class_name => 'Material', :foreign_key => 'parent_id'
  has_many :supplies
  has_many :guilds, :through => :supplies
  has_many :sales
  has_many :users, :through => :sales
#  validates :subject, :presence => true
  has_and_belongs_to_many :options
  has_and_belongs_to_many :orders
  default_scope :order => "materials.name ASC"
  
  accepts_nested_attributes_for :options
  
  def discipline_id
    subject && subject.disciplines && subject.disciplines.first.id
  end
  
  def faculty_id
    subject && subject.disciplines && subject.disciplines.first.faculty.id
  end
  
  def institute_id
    subject && subject.disciplines && subject.disciplines.first.faculty.institute.id
  end
  
end

# == Schema Information
#
# Table name: materials
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  subject_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  nr         :integer(4)
#

