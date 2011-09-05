class PrintJob < ActiveRecord::Base
	has_many :print_job_items
	has_many :materials, :through => :print_job_items
	
	validates :status, :presence => true
end
