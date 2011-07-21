require 'spec_helper'

describe MaterialOption do
  subject { Factory(:material_option) }
  
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:material) }
  
  it { should belong_to(:material) }
end
