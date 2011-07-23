class Association < ActiveRecord::Base
  attr_accessible :name, :initials, :users, :disciplines
  validates :name, :presence => true
  validates :initials, :presence => true
  validate :has_at_least_one_discipline
  
  validates_uniqueness_of :name
  validates_uniqueness_of :initials
  
  has_and_belongs_to_many :disciplines
  has_and_belongs_to_many :users
  default_scope :order => "associations.name ASC"
  def has_at_least_one_discipline
    errors.add(:disciplines, "can't be blank") if
      disciplines.empty?
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

