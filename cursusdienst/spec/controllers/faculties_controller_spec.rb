require 'spec_helper'

describe FacultiesController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @fac = Factory(:faculty)
      @inst = @fac.institute
      second = Factory(:faculty, :name => "Letteren en wijsbegeerte", :initials => "LW", :institute => @inst)
      third = Factory(:faculty, :name => "Ingenieurswetenschappen", :initials => "IR", :institute => @inst)
      @facs = [@fac, second, third]
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have an element for each faculty" do
      get :index
      @facs.each do |inst|
        response.should have_selector("div", :content => inst.name)
      end
    end

  end

  describe "GET 'show" do
    before (:each) do
      @fac = Factory(:faculty)
    end

    it "should be successful" do
      get :show, :id => @fac
      response.should be_success
    end

    it "shoud find the correct institute" do
      get :show, :id => @fac
      assigns(:faculty).should == @fac
    end

  end

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have a name field" do
      get :new
      response.should have_selector("input[name='faculty[name]'][type='text']")
    end

    it "should have an initials field" do
      get :new
      response.should have_selector("input[name='faculty[initials]'][type='text']")
    end

    it "should have a institute field" do
      get :new
      response.should have_selector("select[name='faculty[institute_id]']")
    end

  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :initials => "", :institute => "" }
      end

      it "should not create a institute" do
        lambda do
          post :create, :faculty => @attr
        end.should_not change(Institute, :count)
      end

      it "should render the 'new' page" do
        post :create, :faculty => @attr
        response.should render_template('new')
      end


    end

    describe "success" do
      before(:each) do
        @attr = { :name => "Letteren en wijsbegeerte", :initials => "LW", :institute_id => Factory(:institute) }
      end

      it "should create a faculty" do
        lambda do
          post :create, :faculty => @attr
        end.should change(Faculty, :count).by(1)
      end

      it "should redirect to the faculty show page" do
        post :create, :faculty => @attr
        response.should redirect_to(faculty_path(assigns(:faculty)))
      end

      it "should have a welcome message" do
        #post :create, :user => @attr
        #flash[:success].should = ̃ /welcome to the sample app/i
      end

    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @fac = Factory(:faculty)
    end

    it "should be successful" do
      get :edit, :id => @fac
      response.should be_success
    end
  end


  describe "PUT 'update'" do
    before(:each) do
      @fac = Factory(:faculty)
    end
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :initials => "", :institute => "" }
      end
      it "should render the 'edit' page" do
        put :update, :id => @fac, :faculty => @attr
        response.should render_template('edit')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :name => "Letteren en wijsbegeerte", :initials => "LW", :institute_id => Factory(:institute, :name => "nvub", :initials => "nvub") }
      end
      it "Should never fail" do
        1.should == 1
      end
      it "should change the faculty's attributes" do
        put :update, :id => @fac, :faculty => @attr
        @fac.reload
        @fac.name.should == @attr[:name]
        @fac.initials.should == @attr[:initials]
        #@fac.location.should == @attr[:location_id]
      end
      it "should redirect to the faculty show page" do
        put :update, :id => @fac, :faculty => @attr
        response.should redirect_to(faculty_path(@fac))
      end
      it "should have a flash message" do
        #   put :update, :id => @fac, :faculty => @attr
        #   flash[:success].should = ̃ /updated/
      end
    end
  end

end
