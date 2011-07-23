class Teaching < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :subject
end

# == Schema Information
#
# Table name: teachings
#
#  id            :integer(4)      not null, primary key
#  discipline_id :integer(4)
#  subject_id    :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

