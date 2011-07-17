require 'spec_helper'

describe InstitutesController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @inst = Factory(:institute)
      second = Factory(:institute)#, :name => "Kat uni leuven", :initials => "KUL", :location => "Leuven")
      third = Factory(:institute)#, :name => "Uni Gent", :initials => "UG", :location => "Gent")
      @insts = [@inst, second, third]
    end

    it "should be successful" do
      get :index
      response.should be_success
    end

    it "should have an element for each user" do
      get :index
      @insts.each do |inst|
        response.should have_selector("div", :content => inst.name)
      end
    end

  end

  describe "GET 'show" do
    before (:each) do
      @inst = Factory(:institute)
    end

    it "should be successful" do
      get :show, :id => @inst
      response.should be_success
    end

    it "shoud find the correct institute" do
      get :show, :id => @inst
      assigns(:institute).should == @inst
    end

  end

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have a name field" do
      get :new
      response.should have_selector("input[name='institute[name]'][type='text']")
    end

    it "should have an initials field" do
      get :new
      response.should have_selector("input[name='institute[initials]'][type='text']")
    end

    it "should have a location field" do
      get :new
      response.should have_selector("input[name='institute[location]'][type='text']")
    end
    
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :initials => "", :location => "" }
      end

      it "should not create a institute" do
        lambda do
          post :create, :institute => @attr
        end.should_not change(Institute, :count)
      end

      it "should render the 'new' page" do
        post :create, :institute => @attr
        response.should render_template('new')
      end


    end

    describe "success" do
      before(:each) do
        @attr = { :name => "Vrije uni brussel", :initials => "VUB", :location => "Brussel" }
      end

      it "should create a user" do
        lambda do
          post :create, :institute => @attr
        end.should change(Institute, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :institute => @attr
        response.should redirect_to(institute_path(assigns(:institute)))
      end

      it "should have a welcome message" do
        #post :create, :user => @attr
        #flash[:success].should = ̃ /welcome to the sample app/i
      end

    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @inst = Factory(:institute)
    end

    it "should be successful" do
      get :edit, :id => @inst
      response.should be_success
    end
  end


  describe "PUT 'update'" do
    before(:each) do
      @inst = Factory(:institute)
    end
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :initials => "", :location => "" }
      end
      it "should render the 'edit' page" do
        put :update, :id => @inst, :institute => @attr
        response.should render_template('edit')
      end
    end
    
    describe "success" do
      before(:each) do
        @attr = { :name => "New VUB", :initials => "NVUB",
          :location => "Bruxelles" }
      end
      it "should change the institute's attributes" do
        put :update, :id => @inst, :institute => @attr
        @inst.reload
        @inst.name.should == @attr[:name]
        @inst.initials.should == @attr[:initials]
        @inst.location.should == @attr[:location]
      end
      it "should redirect to the institute show page" do
        put :update, :id => @inst, :institute => @attr
        response.should redirect_to(institute_path(@inst))
      end
      it "should have a flash message" do
        #   put :update, :id => @inst, :institute => @attr
        #   flash[:success].should = ̃ /updated/
      end
    end
  end
  
end

