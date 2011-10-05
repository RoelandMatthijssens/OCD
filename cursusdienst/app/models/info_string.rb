class InfoString < ActiveRecord::Base
  validates :guild, :presence => true
  validates :key, :presence => true
  validates :content, :presence => true

  default_scope :conditions => {:deleted=>false}
  belongs_to :guild
end
