require 'spec_helper'

describe Population do
  
  before(:each) do
    @region = Factory(:region)
    @attr = { :year => 1999,
              :total_pop_thous => 986, 
              :total_pop_estimated => false, 
              :total_pop_break_in_series => false, 
              :total_pop_see_explan => false,
              :pop_density_perkm2 => 282.3 }
  end
  
  it "should create a new instance given valid attributes" do
    @region.populations.create!(@attr)
  end
  
  describe "region associations" do
    
    before(:each) do
      @pop = @region.populations.create(@attr)
    end
    
    it "should have a region attribute" do
      @pop.should respond_to(:region)
    end
    
    it "should have the right associated region" do
      @pop.region_id.should == @region.id
      @pop.region.should == @region
    end
    
    it "should require a unique region and year" do
		  expect do
		    pop2 = @region.populations.create(@attr)
		  end.to raise_error(ActiveRecord::RecordNotUnique)
	  end
    
  end #region assoc
  
  describe "validations" do
    
    it "should require a region id" do
      Population.new(@attr).should_not be_valid
    end
    
    it "should require a year" do
      @region.populations.
        build(@attr.merge(:year => nil)).should_not be_valid
    end
    
  end #valid

end
