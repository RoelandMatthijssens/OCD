require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the SubjectsTestsHelper. For example:
#
# describe SubjectsTestsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
module SubjectsTestsHelper
  def find_selector(page, time)
    until !page.has_select?("subject_disciplines_attributes_#{time}_id")
      time+1
      puts "subject_disciplines_attributes_#{time}_id"
    end
    return "subject_disciplines_attributes_#{time+1}_id"
  end
end
