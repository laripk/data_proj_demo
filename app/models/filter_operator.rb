class FilterOperator
  include ActiveModel::Serialization
  extend ActiveModel::Naming
  include ActiveModel::MassAssignmentSecurity

  attr_accessor :name, :display, :action
  
  def initialize(name, display, action)
    @name = name
    @display = display
    @action = action
  end
  
  def self.all
    list = {}
    list[:less_than] = new({:name => :less_than, 
                            :display => "<", 
                            :action => " < :value"})
    
  end

end
