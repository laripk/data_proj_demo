class Filter
  include ActiveModel::Serialization
  extend ActiveModel::Naming
  include ActiveModel::MassAssignmentSecurity
  
  attr_accessor :field_name, :filter_operator, :value
  
  
  
end
