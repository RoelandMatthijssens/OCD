class Stock < ActiveRecord::Base
  attr_accessible :amount, :material_id, :guild_id, :guild, :material, :floating

  belongs_to :guild
  belongs_to :material

  validates :amount, :presence => true
  #validates :typee, :presence => true
  before_save :default_values
  #default_scope :conditions => {:deleted=>false}

  def default_values
    self.floating = 0 unless self.floating
  end

end
