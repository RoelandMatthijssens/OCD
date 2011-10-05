class Price < ActiveRecord::Base
  attr_accessible :typee, :option, :price_set, :option_id, :price_set_id, :amount
  belongs_to :price_set
  belongs_to :option

  validates :price_set, :presence => true
  validates :option, :presence => true
  validates :typee, :presence => true
  validates :amount, :presence => true

  validates_numericality_of :amount
  validates_uniqueness_of :option_id, :scope => :price_set_id

  default_scope :conditions => {:deleted=>false}
end
