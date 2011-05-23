# == Schema Information
# Schema version: 20110523032743
#
# Table name: death_rates
#
#  id                     :integer         not null, primary key
#  region_id              :integer
#  start_year             :integer
#  end_year               :integer
#  all_causes             :float
#  all_causes_provisional :boolean
#  created_at             :datetime
#  updated_at             :datetime
#

class DeathRate < ActiveRecord::Base
  attr_accessible :start_year, :end_year, :all_causes, 
                  :all_causes_provisional
  
  belongs_to :region
  
  validates :region_id,  :presence => true
  validates :start_year, :presence => true
  validates :end_year,   :presence => true
  
  def self.describe
    descriptions = {
      :death_rates => "Standardised death rate per 100,000 inhabitants, 3 years average.",
      :all_causes => "Deaths due to all causes of death in a region."
    }
  end
end
