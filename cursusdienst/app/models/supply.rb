class Supply < ActiveRecord::Base
  attr_accessible :guild_id, :material_id, :price_set_id
  belongs_to :guild
  belongs_to :material
  belongs_to :price_set

  validates :guild, :presence => true
  validates :price_set, :presence => true
  validates :material, :presence => true
  validates_uniqueness_of :guild_id, :scope => :material_id

  def buy_price
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
  end
end
