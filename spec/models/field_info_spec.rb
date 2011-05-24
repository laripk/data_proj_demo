require 'spec_helper'

describe FieldInfo do

  before(:each) do
    @attr = {
      :name => "Human Readable Name",
      :description => "Long description of what's in this field.",
      :time_range_type => "Year",
      :model_klass => DeathRate, # class
      :model_field => :all_causes # symbol for field
    }
  end
  
  describe "creation and validation" do
    
    it "should create a new instance given valid attributes" do
      fi = FieldInfo.new(@attr)
      fi.should_not be_nil
    end
    
    it "should save the data" do
      fi = FieldInfo.new(@attr)
      fi.name.should == @attr[:name]
      fi.description.should == @attr[:description]
      fi.time_range_type.should == @attr[:time_range_type]
      fi.model_klass.should == @attr[:model_klass]
      fi.model_field.should == @attr[:model_field]
    end
    
    it "should prevent changing the name" do
      fi = FieldInfo.new(@attr)
      expect do
        fi.name = "New Name"
      end.to raise_error(NoMethodError)
    end
    
    it "should prevent changing the description" do
      fi = FieldInfo.new(@attr)
      expect do
        fi.description = "New Description"
      end.to raise_error(NoMethodError)
    end
    
    it "should prevent changing the time_range_type" do
      fi = FieldInfo.new(@attr)
      expect do
        fi.time_range_type = "New Time"
      end.to raise_error(NoMethodError)
    end
    
    it "should prevent changing the model_klass" do
      fi = FieldInfo.new(@attr)
      expect do
        fi.model_klass = Population
      end.to raise_error(NoMethodError)
    end
    
    it "should prevent changing the model_field" do
      fi = FieldInfo.new(@attr)
      expect do
        fi.model_field = :new_field
      end.to raise_error(NoMethodError)
    end
    
  end
  
end
