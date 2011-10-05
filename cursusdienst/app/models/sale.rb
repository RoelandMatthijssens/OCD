class Sale < ActiveRecord::Base
  belongs_to :user
  belongs_to :material

  default_scope :conditions => {:deleted=>false}
end
