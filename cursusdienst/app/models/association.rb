class Association < ActiveRecord::Base
  attr_accessible :name, :initials
  validates :name, :presence => true
  validates :initials, :presence => true
  validates :discipline_id, :presence => true
  belongs_to :discipline
  has_many :users
  validates_uniqueness_of :name, :initials
  default_scope :order => "associations.name ASC"
  
end
