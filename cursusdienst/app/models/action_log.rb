class ActionLog < ActiveRecord::Base

  validates :user, :presence => true
  belongs_to :user
  default_scope :order => "faculties.name ASC", :conditions => {:deleted=>false}
end
