class Supply < ActiveRecord::Base
  
  belongs_to :guild
  belongs_to :material
  
end
