# == Schema Information
# Schema version: 20110528005942
#
# Table name: populations
#
#  id                        :integer(4)      not null, primary key
#  region_id                 :integer(4)
#  year                      :integer(4)
#  total_pop_thous           :integer(4)
#  total_pop_estimated       :boolean(1)
#  total_pop_break_in_series :boolean(1)
#  total_pop_see_explan      :boolean(1)
#  created_at                :datetime
#  updated_at                :datetime
#  pop_density_perkm2        :float
#

class Population < ActiveRecord::Base
  attr_accessible :year, :total_pop_thous, :total_pop_estimated, 
                  :total_pop_break_in_series, :total_pop_see_explan,
                  :pop_density_perkm2
  
  belongs_to :region
  
  validates :region_id, :presence => true
  validates :year,      :presence => true
  
  def self.describe
    descriptions = {
      :populations => "Population information by year.",
      :total_pop_thous => "Total population resident in a region. Average of population at the beginning of the year and population at the end of the year. (1,000 inhabitants)",
      :pop_density_perkm2 => "Total population divided by the surface area. (inhabitants per square km) For calculation of population density, the land area concept (excluding inland water bodies like lakes or rivers) should be used wherever available. In several countries the total area, including area of lakes and rivers, is used because it is the only concept for which data are available."
    }
  end
end
