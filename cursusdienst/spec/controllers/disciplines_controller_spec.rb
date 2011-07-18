require 'spec_helper'

describe DisciplinesController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @dis = Factory(:discipline)
      @fac = @dis.faculty
      second = Factory(:discipline, :name => "Psychologie", :faculty => @fac)
      third = Factory(:discipline, :name => "Rechten", :faculty => @fac)
      @diss = [@dis, second, third]
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have an element for each discipline" do
      get :index
      @diss.each do |fac|
        response.should have_selector("div", :content => fac.name)
      end
    end

  end

  describe "GET 'show" do
    before (:each) do
      @dis = Factory(:discipline)
    end

    it "should be successful" do
      get :show, :id => @dis
      response.should be_success
    end

    it "shoud find the correct faculty" do
      get :show, :id => @dis
      assigns(:discipline).should == @dis
    end

  end

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have a name field" do
      get :new
      response.should have_selector("input[name='discipline[name]'][type='text']")
    end

  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "" }
      end

      it "should not create a faculty" do
        lambda do
          post :create, :discipline => @attr
        end.should_not change(Faculty, :count)
      end

      it "should render the 'new' page" do
        post :create, :discipline => @attr
        response.should render_template('new')
      end


    end

    describe "success" do
      before(:each) do
        @attr = { :name => "Psychologie", :faculty_id => Factory(:faculty) }
      end

      it "should create a discipline" do
        lambda do
          post :create, :discipline => @attr
        end.should change(Discipline, :count).by(1)
      end

      it "should redirect to the discipline show page" do
        post :create, :discipline => @attr
        response.should redirect_to(discipline_path(assigns(:discipline)))
      end

      it "should have a welcome message" do
        #post :create, :user => @attr
        #flash[:success].should = ̃ /welcome to the sample app/i
      end

    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @dis = Factory(:discipline)
    end

    it "should be successful" do
      get :edit, :id => @dis
      response.should be_success
    end
  end


  describe "PUT 'update'" do
    before(:each) do
      @dis = Factory(:discipline)
    end
    describe "failure" do
      before(:each) do
        @attr = { :name => "" }
      end
      it "should render the 'edit' page" do
        put :update, :id => @dis, :discipline => @attr
        response.should render_template('edit')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :name => "Psychologie", :faculty_id => Factory(:faculty, :name => "Something", :initials => "s") }
      end
      it "Should never fail" do
        1.should == 1
      end
      it "should change the discipline's attributes" do
        put :update, :id => @dis, :discipline => @attr
        @dis.reload
        @dis.name.should == @attr[:name]
        #@dis.location.should == @attr[:location_id]
      end
      it "should redirect to the discipline show page" do
        put :update, :id => @dis, :discipline => @attr
        response.should redirect_to(discipline_path(@dis))
      end
      it "should have a flash message" do
        #   put :update, :id => @dis, :discipline => @attr
        #   flash[:success].should = ̃ /updated/
      end
    end
  end

end
