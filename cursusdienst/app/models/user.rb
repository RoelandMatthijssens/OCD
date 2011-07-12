#      t.string :full_name
#      t.string :user_name
#      t.column :rolno, :smallint
#      t.integer :discipline_id
#      t.string :email

class User < ActiveRecord::Base
  attr_accessible :full_name, :user_name, :rolno, :email
  
  validates :user_name, :presence => true
  validates :rolno, :presence => true
  validates_uniqueness_of :user_name, :rolno
  
#  has_and_belongs_to_many :disciplines
#  test
#  has_many :permissions
#  belongs_to :permission   # does not seem to be correct, should be the other way around

end
