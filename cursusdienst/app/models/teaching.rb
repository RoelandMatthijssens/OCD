class Teaching < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :subject
end
