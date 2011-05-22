require 'spec_helper'

describe Region do
	
	before(:each) do
		@attr = {
			:code => "SAMP",
			:description => "This is a sample region"
		}
	end
	
	describe "creation and validation" do
	
		it "should create a new instance given valid attributes" do
			Region.create!(@attr)
		end
		
		it "should save the data" do
			Region.create!(@attr)
			region = Region.first
			# puts "db", region.code
			# puts "tst", @attr[:code]
			region.code.should == @attr[:code]
			region.description.should == @attr[:description]
		end
	
		it "should require a code" do
			no_code_region = Region.new(@attr.merge(:code => ""))
			no_code_region.should_not be_valid
		end
	
		it "should require a description" do
			no_descrip_region = Region.new(@attr.merge(:description => ""))
			no_descrip_region.should_not be_valid
		end
		
		it "should require a unique code" do
		  expect do
		    Region.create!(@attr)
		    Region.create!(@attr.merge(:description => "second time"))
		  end.to raise_error(ActiveRecord::RecordNotUnique)
	  end
	
	end
	
	describe "population associations" do
	  
	  before(:each) do
	    @region = Factory(:region)
    end
    
    it "should have a populations attribute" do
      @region.should respond_to(:populations)
    end
    
  end
end
