class Material < ActiveRecord::Base
#  attr_accessible :name
  validates :name, :presence => true
  validates :nr, :presence => true
  belongs_to :subject
  validates :subject, :presence => true
  has_many :material_options
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

