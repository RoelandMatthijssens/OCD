class Stock < ActiveRecord::Base
  attr_accessible :amount, :material_id, :guild_id, :guild, :material, :floating

  belongs_to :guild
  belongs_to :material

  validates :amount, :presence => true
  #validates :typee, :presence => true
  before_save :default_values

  scope :active, :conditions => {:deleted=>false}

  def default_values
    self.floating = 0 unless self.floating
  end
  
  def stock_to_floating(amount = 1)
    self.amount -= amount
    self.floating += amount
    self.save
  end
  
  def floating_to_stock(amount = 1)
    self.amount += amount
    self.floating -= amount
    self.save
  end

  def get_one_from_floating(amount = 1)
    self.floating -= amount
    self.save
  end
  
  def get_from_floating(amount = 1)
    self.floating -= amount
    self.save
  end
end
