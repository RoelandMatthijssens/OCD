class Institute < ActiveRecord::Base
  attr_accessible :name, :initials, :location

  validates :name, :presence => true
  validates :initials, :presence => true
  validates :location, :presence => true

  validates_uniqueness_of :name, :initials

  has_many :faculties, :dependent => :destroy
  has_many :orders

  #default_scope :conditions => {:deleted=>false}

  def to_delete
    result = []
    reflections.each do |relation_name, relation|
      self.send(relation_name).each do |x|
        result << (x)
      end
    end
    return result
  end
end

# == Schema Information
#
# Table name: institutes
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  initials   :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#
