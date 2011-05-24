require 'spec_helper'

describe Region do
	
	before(:each) do
		@attr = {
			:code => "SAMP",
			:description => "This is a sample region"
		}
	end
	
	describe "creation and validation" do
	
		it "should create a new solo instance given valid attributes" do
			Region.create!(@attr)
		end
		
		it "should create a new country-child instance given valid attributes" do
		  country = Factory(:country)
		  region = country.regions.create!(@attr)
			region.code.should == @attr[:code]
			region.description.should == @attr[:description]
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
	
	describe "country associations" do
	  
	  before(:each) do
	    @country = Factory(:country)
	    @region = @country.regions.create!(@attr)
    end
    
    it "should have a country attribute" do
      @region.should respond_to(:country)
    end
    
    it "should have the right associated country" do
      @region.country_id.should == @country.id
      @region.country.should == @country
    end
	  
  end
	
	describe "associations with" do
	
	  before(:each) do
	    @region = Factory(:region)
    end
  
  	describe "population" do
	  
      it "should have a populations attribute" do
        @region.should respond_to(:populations)
      end
      
      it "should have a working populations attribute" do
        expect do
          @region.populations.should be_empty
        end.to_not raise_error
      end
    
    end
	
  	describe "death rate" do
	  
      it "should have a death_rates attribute" do
        @region.should respond_to(:death_rates)
      end
    
      it "should have a working death_rates attribute" do
        expect do
          @region.death_rates.should be_empty
        end.to_not raise_error
      end
    
    end
  
  	describe "household income" do
	  
      it "should have a household_incomes attribute" do
        @region.should respond_to(:household_incomes)
      end
    
      it "should have a working household_incomes attribute" do
        expect do
          @region.household_incomes.should be_empty
        end.to_not raise_error
      end
    
    end
  
  end #assoc
  
end
