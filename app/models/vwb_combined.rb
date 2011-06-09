# == Schema Information
# Schema version: 20110602102822
#
# Table name: vwb_combineds
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
#

class VwbCombined < ActiveRecord::Base
  before_save    { false }
  before_destroy { false }
end
