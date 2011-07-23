class MaterialOption < ActiveRecord::Base
  attr_accessible :key, :value
  validates :material, :presence => true
  validates :key, :presence => true, :uniqueness => {:scope => :material_id}
  validates :value, :presence => true
  belongs_to :material
end

# == Schema Information
#
# Table name: material_options
#
#  id          :integer(4)      not null, primary key
#  key         :string(255)
#  value       :string(255)
#  material_id :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

