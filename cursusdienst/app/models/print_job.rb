class PrintJob < ActiveRecord::Base
  has_many :material_orders
  has_many :materials, :through => :print_job_items

  validates :status, :presence => true
end
