class Material < ActiveRecord::Base
#  attr_accessible :name
  validates :name, :presence => true
  validates :nr, :presence => true
  belongs_to :subject
  validates :subject, :presence => true
  has_many :material_options
end
