require 'spec_helper'

describe DeathRate do
  
  before(:each) do
    @region = Factory(:region)
    @attr = { :start_year => 2000,
              :end_year => 2002,
              :all_causes => 56.8,
              :all_causes_provisional => false }
  end
  
  it "should create a new instance given valid attributes" do
    @region.death_rates.create!(@attr)
  end
  
  describe "region associations" do
    
    before(:each) do
      @death_rate = @region.death_rates.create(@attr)
    end
    
    it "should have a region attribute" do
      @death_rate.should respond_to(:region)
    end
    
    it "should have the right associated region" do
      @death_rate.region_id.should == @region.id
      @death_rate.region.should == @region
    end
    
    it "should require a unique region and start_year" do
      expect do
        rate2 = @region.death_rates.create(@attr)
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
    
  end #region assoc

  describe "validations" do
    
    it "should require a region id" do
      DeathRate.new(@attr).should_not be_valid
    end
    
    it "should require a start_year" do
      @region.death_rates.
        build(@attr.merge(:start_year => nil)).should_not be_valid
    end
    
    it "should require an end_year" do
      @region.death_rates.
        build(@attr.merge(:end_year => nil)).should_not be_valid
    end
    
  end #valid
  
end
