class BookCost < ActiveRecord::Base
  attr_accessible :supply_id, :amount

  validates :supply, :presence => true
  validates :amount, :presence => true

  belongs_to :supply

  default_scope :order => "book_costs.created_at DESC"
end
