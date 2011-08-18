class Message < ActiveRecord::Base
  attr_accessible :content
	belongs_to :guild
  validates :guild, :presence => true
  validates :content, :presence => true,
    :length => { :within => 5..255 }
  default_scope :order => "messages.created_at DESC"
end
