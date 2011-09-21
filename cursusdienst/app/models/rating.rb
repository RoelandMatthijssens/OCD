class Rating < ActiveRecord::Base
  attr_accessible :score, :message, :user
  
  belongs_to :user
  belongs_to :rateable, :polymorphic => true
  
end
