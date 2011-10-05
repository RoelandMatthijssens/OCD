class PrintJob < ActiveRecord::Base
  has_many :material_orders
  has_many :materials, :through => :print_job_items

  accepts_nested_attributes_for :material_orders
  default_scope :conditions => {:deleted=>false}

  def status
    s = { 'Posted' => 1, 'Payed' => 2, 'Ordered' => 3, 'Delivered' => 4,'Ready' => 5, 'Done' => 6, 'Canceled' => 0 }
    r = 'Done'
    x = material_orders
    x.each do |i|
      r = i.status if s[i.status] < s[r]
    end
    return r
  end

end
