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

  scope :active, :conditions => {:deleted=>false}

  def buy_price
    if material.printable
      options = material.options
      pages = material.page_count
      build_total = [options]
      options.each do |option|
        if option.typee == 'printer'
          option_price = price_set.prices.find(:all, :conditions => ['option_id=?', option.id]).first
          price = option_price.amount
          type = option_price.typee
          if type == 'per_page'
            build_total << price * pages
          else
            build_total << price
          end
        end
      end
      total = 0
      if build_total[1] && build_total[2]
        total = build_total[1] + build_total[2]
      end
      return total
    else
      if book_costs.empty?
        nil
      else
        return book_costs.first.amount
      end
    end
  end
end
