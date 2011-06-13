# == Schema Information
# Schema version: 20110603123608
#
# Table name: queries
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)
#  selected_fields  :text
#  selected_filters :text
#  is_active        :boolean(1)      default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#

class Query < ActiveRecord::Base
  attr_accessible :name, :selected_fields, :selected_filters
    
  serialize :selected_fields,  Array 
  serialize :selected_filters, Hash
  
  validates :name,            :presence => true
  validates :is_active,       :presence => true
  validates :selected_fields, :presence => true
  
  default_scope where(:is_active => true).order(:id.desc)
  
  
  # def initialize(attributes=nil)
  #   super attributes
  #   if @is_active.nil?
  #     @is_active = true
  #   end
  # end
  
end
