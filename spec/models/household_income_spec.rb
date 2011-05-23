require 'spec_helper'

describe HouseholdIncome do
  
  before(:each) do
    @region = Factory(:region)
    @attr = { :year => 2001,
              :primary => 189765.2,
              :primary_estimated => false,
              :primary_break_in_series => false,
              :primary_see_explan => false }
  end
  
  it "should create a new instance given valid attributes" do
    @region.household_incomes.create!(@attr)
  end
  
  describe "region associations" do
    
    before(:each) do
      @income = @region.household_incomes.create(@attr)
    end
    
    it "should have a region attribute" do
      @income.should respond_to(:region)
    end
    
    it "should have the right associated region" do
      @income.region_id.should == @region.id
      @income.region.should == @region
    end
    
    it "should require a unique region and year" do
      expect do
        income2 = @region.household_incomes.create(@attr)
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
    
  end #region assoc

  describe "validations" do
    
    it "should require a region id" do
      HouseholdIncome.new(@attr).should_not be_valid
    end
    
    it "should require a year" do
      @region.household_incomes.
        build(@attr.merge(:year => nil)).should_not be_valid
    end
    
  end #valid

end
