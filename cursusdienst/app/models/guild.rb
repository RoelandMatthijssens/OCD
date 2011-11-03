class Guild < ActiveRecord::Base
  attr_accessible :name, :initials, :users, :disciplines, :materials
  validates :name, :presence => true
  validates :initials, :presence => true
  validate :has_at_least_one_discipline

  validates_uniqueness_of :name
  validates_uniqueness_of :initials

  has_and_belongs_to_many :disciplines
  has_and_belongs_to_many :users
  has_many :supplies, :dependent => :destroy
  has_many :materials, :through => :supplies
  has_many :messages
  has_many :shopping_cart_items
  has_many :material_orders
  has_many :info_strings

  default_scope :order => "guilds.name ASC"
  scope :active, :conditions => {:deleted=>false}

  accepts_nested_attributes_for :disciplines

  def has_at_least_one_discipline
    errors.add(:disciplines, "can't be blank") if
      disciplines.empty?
  end

  def subjects
    s = []
    disciplines.each { |d|
      s.concat d.subjects
    }
    s
  end

  def info info_type
    r = info_strings.find_all{|item| item.key == info_type }
    if r.size > 0
      r[0]
    else
      nil
    end
  end

  def payed_orders start_date=0, end_date=Time.now()
    filter_status = ['Posted', 'Canceled']
    payed_orders = []
    material_orders.find(:all, :conditions => ["created_at > ? AND created_at < ?", start_date, end_date]).each do |material_order|
      unless filter_status.include? material_order.status
        payed_orders << material_order
      end
    end
    return payed_orders
  end

  def grand_total start_date=0, end_date=Time.now()
    filter_status = ['Posted', 'Canceled']
    grand_total = 0
    all_payed_orders = []
    MaterialOrder.find(:all, :conditions => ["created_at > ? AND created_at < ?", start_date, end_date]).each do |material_order|
      unless filter_status.include? material_order.status
        all_payed_orders << material_order
      end
    end
    all_payed_orders.each do |order|
      material = order.material
      amount = order.amount
      supply = Supply.find(:first, :conditions => ["material_id = ? and guild_id = ?", material.id, order.guild_id])
      grand_total += (supply.price - supply.buy_price) * amount
    end
    return grand_total
  end

  def all_totals start_date=0, end_date=Time.now()
    total_cost = 0
    total_revenue = 0
    total_profit = 0
    total_items = 0
    orders = payed_orders(start_date, end_date)
    orders.each do |order|
      material = order.material
      amount = order.amount
      supply = Supply.find(:first, :conditions => ["material_id = ? and guild_id = ?", material.id, id])
      total_cost += supply.buy_price * amount
      total_revenue += supply.price * amount
      total_profit += (supply.price - supply.buy_price) * amount
      total_items += amount
    end
    return [total_cost, total_revenue, total_profit, total_items]
  end

  def total_expenses start_date=0, end_date=Time.now()
    return all_totals[0]
  end
  def total_profit start_date=0, end_date=Time.now()
    return all_totals[1]
  end
  def total_items start_date=0, end_date=Time.now()
    return all_totals[2]
  end

end

# == Schema Information
#
# Table name: associations
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  initials      :string(255)
#  discipline_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#
