class MaterialOrder < ActiveRecord::Base
  belongs_to :material
  belongs_to :order
  belongs_to :guild

  validates :material, :presence => true
  validates :order, :presence => true
  validates :guild, :presence => true
end
