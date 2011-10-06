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
  default_scope :order => "guilds.name ASC"#, :conditions => {:deleted=>false}

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
