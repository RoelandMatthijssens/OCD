class ActionLog < ActiveRecord::Base

  validates :user, :presence => true
  belongs_to :user
  #default_scope :conditions => {:deleted=>false}
end
