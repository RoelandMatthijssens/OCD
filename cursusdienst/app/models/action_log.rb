class ActionLog < ActiveRecord::Base

  validates :user, :presence => true
  belongs_to :user

  scope :active, :conditions => {:deleted=>false}
end
