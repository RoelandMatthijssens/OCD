class Material < ActiveRecord::Base
  attr_accessible :name, :subject_id, :guilds, :material_options, :parent, :parent_id, :path_name, :attachments_attributes, :price, :typee, :info

  has_many :attachments
  accepts_nested_attributes_for :attachments

  validates :name, :presence => true
  #validates :price, :presence => true
  validates :typee, :presence => true
  belongs_to :subject
  belongs_to :parent, :class_name => 'Material', :foreign_key => 'parent_id'
  has_many :supplies
  has_many :guilds, :through => :supplies
  has_many :sales
  has_many :users, :through => :sales
  has_many :print_job_items
  has_many :print_jobs, :through => :print_job_items
  has_and_belongs_to_many :extra_options
  has_many :material_orders
  has_many :orders, :through => :material_orders
  default_scope :order => "materials.name ASC"

  accepts_nested_attributes_for :extra_options

  def discipline_id
    subject && subject.disciplines && subject.disciplines.first.id
  end

  def faculty_id
    subject && subject.disciplines && subject.disciplines.first.faculty.id
  end

  def institute_id
    subject && subject.disciplines && subject.disciplines.first.faculty.institute.id
  end

  def get_subject(ring_check = [])
    ring_check << self
    if self.subject
      return subject
    elsif self.parent
      if ring_check.contains self.parent
        raise "ring detected"
      else
        return self.parent.get_subject(ring_check)
      end
    else
      raise "No subject attached"
    end
  end

  def get_price
    if price
      return price
    elsif parent
      return parent.get_price
    else
      return nil
    end
  end
end

# == Schema Information
#
# Table name: materials
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  subject_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  nr         :integer(4)
#
