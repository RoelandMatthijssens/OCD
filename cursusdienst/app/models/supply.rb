class PriceExclusivePresence < ActiveModel::Validator
  def validate(record)
    if (Material.find(record.material_id).printable)
      record.errors[:price_set] << "Please give a price set" unless record.price_set_id
    else
      record.errors[:book_costs] << "Please give a book cost" unless record.book_costs
    end
  end
end

class Supply < ActiveRecord::Base
  attr_accessible :guild_id, :material_id, :price_set_id, :price, :book_costs
  belongs_to :guild
  belongs_to :material
  belongs_to :price_set
  has_many :book_costs

  validates :guild, :presence => true
  #validates :price_set, :presence => true
  validates :price, :presence => true
  validates :material, :presence => true
  validates_uniqueness_of :guild_id, :scope => :material_id
  
  validates_with PriceExclusivePresence


  def buy_price
    if material.printable
      options = material.options
      pages = material.page_count
      total = 0
      options.each do |option|
        option_price = price_set.prices.find(:all, :conditions => ['option_id=?', option.id]).first
        price = option_price.amount
        type = option_price.typee
        if type == 'per_page'
          total += price * pages
        else
          total += price
        end
      end
      return total
    else
      if book_costs.empty?
        nil
      else
        return book_costs.first
      end
    end
  end
end
