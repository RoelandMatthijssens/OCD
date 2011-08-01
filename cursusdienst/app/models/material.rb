class Material < ActiveRecord::Base
  attr_accessible :name, :subject_id, :guilds, :material_options
  validates :name, :presence => true
  #validates :nr, :presence => true
  belongs_to :subject
  has_many :sales
  has_many :guilds, :through => :sales
#  validates :subject, :presence => true
  has_many :material_options
  default_scope :order => "materials.name ASC"
  
#  accepts_nested_attributes_for :subject
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

