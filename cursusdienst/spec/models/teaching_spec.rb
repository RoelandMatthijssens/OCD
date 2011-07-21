describe Teaching do
  subject { Factory(:teaching) }
  
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
end
