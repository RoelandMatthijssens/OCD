class Discipline < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :faculty
end
