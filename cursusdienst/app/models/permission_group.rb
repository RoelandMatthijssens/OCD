class PermissionGroup < ActiveRecord::Base
  attr_accessible :name, :level
  validates :name, :presence => true
  validates :level, :presence => true
  validates_uniqueness_of :name
  validates_uniqueness_of :level
  has_many :users
end

# == Schema Information
#
# Table name: permission_groups
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  level      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

