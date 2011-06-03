# == Schema Information
# Schema version: 20110602111108
#
# Table name: vwc_all_combineds
#
#  region_id                      :integer(4)
#  year                           :integer(4)
#  total_population               :integer(4)
#  population_density             :float
#  primary_income                 :float
#  start_year_death_rate          :integer(4)
#  end_year_death_rate            :integer(4)
#  all_causes_death_rate          :float
#  cancer_death_rate              :float
#  heart_disease_death_rate       :float
#  all_accidents_death_rate       :float
#  transport_accidents_death_rate :float
#  region_code                    :string(20)
#  region_description             :string(255)
#  country_code                   :string(2)
#  country_description            :string(255)
#

class VwcAllCombined < ActiveRecord::Base
  before_save    { false }
  before_destroy { false }
end
