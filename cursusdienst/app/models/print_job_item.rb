class PrintJobItem < ActiveRecord::Base
	belongs_to :print_job
	belongs_to :material
end
