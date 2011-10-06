class Rating < ActiveRecord::Base
  attr_accessible :score, :message, :user

  belongs_to :user
  belongs_to :rateable, :polymorphic => true

  validates_presence_of :score
  validates_presence_of :user

  validates :score, :inclusion => {:in => 1..5}
  scope :active, :conditions => {:deleted=>false}
end
