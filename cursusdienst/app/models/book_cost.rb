class BookCost < ActiveRecord::Base

  validates :material, :presence => true
  validates :amount, :presence => true

  default_scope :order => "book_costs.created_at DSC"
end
