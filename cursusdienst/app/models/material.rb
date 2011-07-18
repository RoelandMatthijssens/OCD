class Material < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  belongs_to :subject
  has_many :materialOptions
end
