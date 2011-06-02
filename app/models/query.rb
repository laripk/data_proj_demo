# == Schema Information
# Schema version: 20110528005942
#
# Table name: queries
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  is_active  :boolean(1)
#  query_def  :text
#  created_at :datetime
#  updated_at :datetime
#

class Query < ActiveRecord::Base
  attr_accessible :name, :query_def
  
  serialize :query_def, QueryDef
  
  validates :name,      :presence => true
  validates :is_active, :presence => true
  validates :query_def, :presence => true
  
  def initialize
    if @is_active.nil?
      @is_active = true
    end
  end
  
end
