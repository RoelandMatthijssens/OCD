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
end
