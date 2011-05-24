require 'spec_helper'

describe Country do
  
  before(:each) do
    @attr = {
      :code => "EX",
      :description => "Example Country"
    }
  end
  
  describe "creation and validation" do
    
    it "should create a new instance given valid attributes" do
      Country.create!(@attr)
    end
    
    it "should save the data" do
      Country.create!(@attr)
      country = Country.first
      country.code.should == @attr[:code]
      country.description.should == @attr[:description]
    end
    
    it "should require a code" do
      no_code = Country.new(@attr.merge(:code => ""))
      no_code.should_not be_valid
    end
    
    it "should require a description" do
      no_description = Country.new(@attr.merge(:description => ""))
      no_description.should_not be_valid
    end
    
		it "should require a unique code" do
		  expect do
		    Country.create!(@attr)
		    Country.create!(@attr.merge(:description => "second time"))
		  end.to raise_error(ActiveRecord::RecordNotUnique)
	  end
	
  end #create & valid
  
  describe "region associations" do
    
    before(:each) do
      @country = Factory(:country)
    end
    
    it "should have a regions attribute" do
      @country.should respond_to(:regions)
    end
    
    it "should have a working regions attribute" do
      expect do
        @country.regions.should be_empty
      end.to_not raise_error
    end
    
  end #region
  
end
