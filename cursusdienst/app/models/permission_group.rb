class PermissionGroup < ActiveRecord::Base
  attr_accessible :name, :level
  validates :name, :presence => true
  validates :level, :presence => true
  validates_uniqueness_of :name
  validates_uniqueness_of :level
  has_many :users
end
