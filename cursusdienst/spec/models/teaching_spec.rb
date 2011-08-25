describe Teaching do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
#  subject { Factory(:teaching) }
  
  it { should belong_to(:discipline) }
  it { should belong_to(:subject) }
  
#  it { should validate_uniqueness_of(:subject_id).scoped_to(:discipline_id) }
  
  it "should create a relation starting from discipline" do
    discipline = Factory(:discipline)
    subject = Factory(:subject)
    lambda do
      discipline.subjects << subject
    end.should change(Teaching, :count).by(1)
  end
  it "should create a relation starting from subject" do
    discipline = Factory(:discipline)
    subject = Factory(:subject)
    lambda do
      subject.disciplines << discipline
    end.should change(Teaching, :count).by(1)
  end
  
  describe "uniqueness per institute" do
    before(:each) do
      @institute1 = Factory(:institute)
      @faculty1 = Factory(:faculty, :institute => @institute1)
      @discipline1 = Factory(:discipline, :faculty => @faculty1)
      @institute2 = Factory(:institute)
      @faculty2 = Factory(:faculty, :institute => @institute2)
      @discipline2 = Factory(:discipline, :faculty => @faculty2)
      @subject1 = Factory(:subject, :name => 'same_name')
      @subject2 = Factory(:subject, :name => 'same_name')
    end
    it "should allow the same name in different schools" do
      lambda do
        @discipline1.subjects << @subject1
        @discipline2.subjects << @subject2
      end.should_not raise_error
    end
    #it "should not allow the same name in same school" do
      #@faculty2.institute = @institute1
      #@faculty2.save!
      #lambda do
        #@discipline1.subjects << @subject1
        #@discipline2.subjects << @subject2
      #end.should raise_error
    #end
  end
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
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

