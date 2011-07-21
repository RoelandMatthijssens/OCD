require 'spec_helper'

describe "InstitutesTests" do
  describe "GET /institutes_tests" do
    before(:each) do
      @inst = Factory(:institute)
      second = Factory(:institute)#, :name => "Kat uni leuven", :initials => "KUL", :location => "Leuven")
      third = Factory(:institute)#, :name => "Uni Gent", :initials => "UG", :location => "Gent")
      @insts = [@inst, second, third]
    end
    
    it "should visit the institutes page" do
      visit institutes_path
    end

    it "index should contain all institute" do
      visit institutes_path
      @insts.each { |i|
        has_content?(i.name).should == true
      }
    end
  end
end
