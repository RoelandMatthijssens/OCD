class InfoString < ActiveRecord::Base
  validates :guild, :presence => true
  validates :key, :presence => true
  validates :content, :presence => true

  belongs_to :guild
end
