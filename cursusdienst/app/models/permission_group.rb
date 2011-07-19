class PermissionGroup < ActiveRecord::Base
  has_many :users
end
