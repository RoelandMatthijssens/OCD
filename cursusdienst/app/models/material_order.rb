class MaterialOrder < ActiveRecord::Base

  attr_accessible :material, :order, :guild, :price, :material_id, :order_id, :guild_id, :amount, :status, :print_job_id, :print_job

  belongs_to :material
  belongs_to :order
  belongs_to :guild
  belongs_to :print_job

  validates :material, :presence => true
  validates :order, :presence => true
  validates :guild, :presence => true
  validates :amount, :presence => true
  validates :price, :presence => true
  validates :status, :presence => true

  scope :active, :conditions => {:deleted=>false}
  
end
