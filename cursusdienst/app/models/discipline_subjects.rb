class Discipline_Subject < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :subject
end
