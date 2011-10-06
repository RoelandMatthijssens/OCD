class Sale < ActiveRecord::Base
  belongs_to :user
  belongs_to :material

  scope :active, :conditions => {:deleted=>false}
end
