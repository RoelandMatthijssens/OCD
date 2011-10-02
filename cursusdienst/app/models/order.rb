class Order < ActiveRecord::Base

  belongs_to :user
  belongs_to :institute
  has_many :material_orders
  has_many :materials, :through => :material_orders

  validates :institute, :presence => true
  validates :user, :presence => true

  def get_random_string(length)
    s = (0...length).map{ ('0'..'10').to_a[rand(10)] }.join
    x = Order.find(:all, :conditions => ['order_key=?', s])
    if x.any?
      get_random_string(length)
    else
      return s
    end
  end

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
