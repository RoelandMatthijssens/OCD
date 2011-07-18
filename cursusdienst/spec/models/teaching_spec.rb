describe Teaching do
  before (:each) do
    faculty = Factory(:faculty)
    @d1 = faculty.disciplines.create(:name => 'ComputerWetenschappen')
    @d2 = faculty.disciplines.create(:name => 'Ingeniuers wetenschappen')
    @s1 = Subject.create(:name => 'Statestiek')
    @s2 = Subject.create(:name => 'Algo En Data')
    @s3 = Subject.create(:name => 'Bouwkunde')
  end
  
  it "should create a relation" do
    lambda do
      @d1.subjects << @s1
    end.should change(Teaching, :count).by(1)
  end
  
  it "should not allow dubbels" do
    @d1.subjects << @s1
    lambda do
      @d1.subjects << @s1
    end.should_not change(Teaching, :count)
  end
  
end
