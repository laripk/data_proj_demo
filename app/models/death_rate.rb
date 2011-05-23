# == Schema Information
# Schema version: 20110523065257
#
# Table name: death_rates
#
#  id                        :integer         not null, primary key
#  region_id                 :integer
#  start_year                :integer
#  end_year                  :integer
#  all_causes                :float
#  all_causes_provisional    :boolean
#  created_at                :datetime
#  updated_at                :datetime
#  cancer                    :float
#  cancer_provisional        :boolean
#  heart_disease             :float
#  heart_disease_provisional :boolean
#  all_accidents             :float
#  all_accidents_provisional :boolean
#

class DeathRate < ActiveRecord::Base
  attr_accessible :start_year, :end_year, 
                  :all_causes, :all_causes_provisional,
                  :cancer, :cancer_provisional,
                  :heart_disease, :heart_disease_provisional,
                  :all_accidents, :all_accidents_provisional
  
  belongs_to :region
  
  validates :region_id,  :presence => true
  validates :start_year, :presence => true
  validates :end_year,   :presence => true
  
  def self.describe
    descriptions = {
      :death_rates => "Standardised death rate per 100,000 inhabitants, 3 years average. Causes of Death data refer to the underlying cause which - according to the World Health Organisation (WHO) - is 'the disease or injury which initiated the train of morbid events leading directly to death, or the circumstances of the accident or violence which produced the fatal injury'.",
      :all_causes => "Deaths due to all causes of death in a region.",
      :cancer => "Deaths due to cancer (all death caused by a malignant neoplasm) in a region.",
      :heart_disease => "Death due to ischemic heart diseases (all death caused by reduced blood supply to the heart - most are due to 'heart attack') in a region.",
      :all_accidents => "Death due to all kinds of accidents (transport, drowning, fire, ...) in a region."
    }
  end
end
