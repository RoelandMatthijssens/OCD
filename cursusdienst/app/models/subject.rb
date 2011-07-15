class Subject < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :disciplines, :class_name => "discipline", :join-table => "discipline_subjects"
  validates :name, :presence => true
end
