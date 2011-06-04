# == Schema Information
# Schema version: 20110603123608
#
# Table name: queries
#
#  id               :integer(4)      not null, primary key
#  name             :string(255)
#  selected_fields  :text
#  selected_filters :text
#  is_active        :boolean(1)
#  created_at       :datetime
#  updated_at       :datetime
#

class Query < ActiveRecord::Base
  attr_accessible :name, :selected_fields, :selected_filters
  
  # for meta_search
  has_many :vwc_all_combineds
  accepts_nested_attributes_for :vwc_all_combineds
  
  # serialize :selected_fields, :selected_filters # not sure if this is right
  
  validates :name,            :presence => true
  validates :is_active,       :presence => true
  validates :selected_fields, :presence => true
  
  def initialize
    super
    if @is_active.nil?
      @is_active = true
    end
  end
  
end