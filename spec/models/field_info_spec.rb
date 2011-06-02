require 'spec_helper'

describe FieldInfo do
  
  describe "creation and validation" do

    before(:each) do
      @attr = {
        :name => :name_symbol,
        :description => "Long description of what's in this field.",
        :time_range_type => "Year",
        :model_klass => DeathRate, # class
        :model_field => :all_causes # symbol for field
      }
    end
    
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
  
  describe "finding" do
    
    it "should find a real field_info" do
      real_fi = FieldInfo.find(:total_population)
      real_fi.should_not be_nil
      real_fi.name.should == :total_population
    end
    
    it "should not find a non-existant field_info" do
      fake_fi = FieldInfo.find(:not_a_real_field_name)
      fake_fi.should be_nil
    end
    
  end
  
end
