class Message < ActiveRecord::Base
  attr_accessible :content
  belongs_to :guild
  validates :guild, :presence => true
  validates :content, :presence => true
  #default_scope :order => "messages.created_at DESC", :conditions => {:deleted=>false}
end
