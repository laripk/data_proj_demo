# == Schema Information
# Schema version: 20110522163302
#
# Table name: populations
#
#  id                        :integer         not null, primary key
#  region_id                 :integer
#  year                      :integer
#  total_pop_thous           :integer
#  total_pop_estimated       :boolean
#  total_pop_break_in_series :boolean
#  total_pop_see_explan      :boolean
#  created_at                :datetime
#  updated_at                :datetime
#

class Population < ActiveRecord::Base
  attr_accessible :year, :total_pop_thous, :total_pop_estimated, 
                  :total_pop_break_in_series, :total_pop_see_explan
  
  belongs_to :region
  
  validates :region_id, :presence => true
  validates :year,      :presence => true
end
