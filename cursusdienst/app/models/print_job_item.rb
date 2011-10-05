class PrintJobItem < ActiveRecord::Base
  belongs_to :print_job
  belongs_to :material

  validates :print_job, :presence => true
  validates :material, :presence => true
  validates :amount, :presence => true

  default_scope :conditions => {:deleted=>false}
end
