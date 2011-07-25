require 'spec_helper'

describe Material do
  subject { Factory(:material) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:nr) }
  it { should validate_presence_of(:subject) }
  
  it { should belong_to(:subject) }
  it { should have_many(:material_options) }
end
