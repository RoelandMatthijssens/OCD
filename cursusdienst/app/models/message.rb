class Message < ActiveRecord::Base
  attr_accessible :content
  belongs_to :guild
  validates :guild, :presence => true
  validates :content, :presence => true

  scope :active, :order => "messages.created_at DESC"
  scope :active, :conditions => {:deleted=>false}
end
