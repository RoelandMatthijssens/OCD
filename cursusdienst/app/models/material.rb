class Numeric
  # same potential floating point problem as round_to
  def truncate_to( decimals=0 )
    factor = 10.0**decimals
    (self*factor).floor / factor
  end
end

class ExclusivePresence < ActiveModel::Validator
  def validate(record)
    unless (record.parent_id ) || (record.subject_id)
      record.errors[:base] << "Either parent or subject have to be given"
    end
  end
end

class Material < ActiveRecord::Base
  attr_accessible :name, :subject_id, :guilds, :material_options, :parent, :parent_id, :path_name, :attachments_attributes, :typee, :info, :printable, :page_count

  has_many :attachments
  accepts_nested_attributes_for :attachments

  validates :name, :presence => true
  validates :typee, :presence => true
  validates :subject_id, :presence => true

  #validates_with ExclusivePresence

  validates :printable, :inclusion => {:in => [true, false]}
  belongs_to :subject
  belongs_to :parent, :class_name => 'Material', :foreign_key => 'parent_id'
  has_many :supplies
  has_many :guilds, :through => :supplies
  has_many :sales
  has_many :users, :through => :sales
  has_many :print_job_items
  has_many :print_jobs, :through => :print_job_items
  has_and_belongs_to_many :options
  has_many :material_orders
  has_many :ratings, :as => :rateable
  has_many :orders, :through => :material_orders
  default_scope :order => "materials.name ASC"

  accepts_nested_attributes_for :options

  def rating_score
    if ratings.any?
      (ratings.inject(0.0){|sum,x| sum + x.score } / ratings.length).round
    else
      0.0
    end
  end

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
      if ring_check.index self.parent
        raise "ring detected"
      else
        return self.parent.get_subject(ring_check)
      end
    else
      raise "No subject attached"
    end
  end

  def printer_options
    x = []
    options.each do |option|
      x << option if option.typee == 'printer'
    end
    return x
  end

  def supply guild
    supply = guild.supplies.find(:all, :conditions => ["material_id=?", id]).first
  end

  def print_type
    print_options = ["single sided - black and white", "Single sided - color", "Duplex - black and white", "Duplex - color",
                     "Inbinding: Lijm + plastiek", "Inbinding: Lijm + zonder plastiek", "Inbinding: Ringen + plastiek", "Inbinding: Ringen + zonder plastiek"]
    result = ""
    (0..print_options.length-1).to_a.each do |i|
      result += i.to_s if options.include?(Option.find_by_name(print_options[i]))
    end
    result = result.to_i
    valid_options = [5, 6, 7, 8, 15, 16, 17, 18, 25, 26, 27, 28, 35, 36, 37, 38]
    return (valid_options.include? result) ? result : 0
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
