class MaterialOption < ActiveRecord::Base
  attr_accessible :key, :value
  validates :key, :presence => true, :uniqueness => {:scope => :material_id}
  validates :value, :presence => true
  belongs_to :material
end
