#      t.string :full_name
#      t.string :user_name
#      t.column :rolno, :smallint
#      t.string :subject
#      t.string :email

class User < ActiveRecord::Base
  attr_accessible :full_name, :user_name, :rolno, :subject, :email
  
  validates :user_name, :presence => true
  validates_uniqueness_of :user_name, :rolno
  
end

