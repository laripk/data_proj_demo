# == Schema Information
# Schema version: 20110528005942
#
# Table name: death_rates
#
#  id                              :integer(4)      not null, primary key
#  region_id                       :integer(4)
#  start_year                      :integer(4)
#  end_year                        :integer(4)
#  all_causes                      :float
#  all_causes_provisional          :boolean(1)
#  created_at                      :datetime
#  updated_at                      :datetime
#  cancer                          :float
#  cancer_provisional              :boolean(1)
#  heart_disease                   :float
#  heart_disease_provisional       :boolean(1)
#  all_accidents                   :float
#  all_accidents_provisional       :boolean(1)
#  transport_accidents             :float
#  transport_accidents_provisional :boolean(1)
#

class DeathRate < ActiveRecord::Base
  attr_accessible :start_year, :end_year, 
                  :all_causes, :all_causes_provisional,
                  :cancer, :cancer_provisional,
                  :heart_disease, :heart_disease_provisional,
                  :all_accidents, :all_accidents_provisional,
                  :transport_accidents, :transport_accidents_provisional
  
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
      :all_accidents => "Death due to all kinds of accidents (transport, drowning, fire, ...) in a region.",
      :transport_accidents => "Death due to transport accidents (all kinds of transport (road: car, pedestrian, cyclist, ..; water; air; ...)) in a region."
    }
  end
end
