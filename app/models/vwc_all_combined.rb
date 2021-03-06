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
  
  scope :regions, select('distinct region_description, region_code').order('region_description')
  scope :countries, select('distinct country_description, country_code').order('country_description')

  # scope :result_order, order(:region_code, :year, :start_year_death_rate)
  RESULT_ORDER = [:region_code, :year, :start_year_death_rate, :end_year_death_rate]

  def self.count_me(sql)
    connection.execute("SELECT COUNT(*) AS cnt FROM ( #{sql} ) frog").first['cnt']
  end

  # :field_name => "Field description"
  def self.field_info
    list = {
      :region_code => "Short code identifying the statistical region.",
      :region_description => "Description for region.",
      :country_code => "Short code for the country.", # (Note: not all regions have associated countries.)
      :country_description => "Description for country.", # (Note: not all regions have associated countries.)
      :year => "Year of measurement. Applies to population and income measurements only.",
      :total_population => "Total population resident in a region. Average of population at the beginning of the year and population at the end of the year. (1,000 inhabitants)",
      :population_density => "Total population divided by the surface area. (inhabitants per square kilometer) In most countries and regions, this does not include inland water (lakes or rivers) as part of the surface area.",
      # "Total population divided by the surface area. (inhabitants per square km) For calculation of population density, the land area concept (excluding inland water bodies like lakes or rivers) should be used wherever available. In several countries the total area, including area of lakes and rivers, is used because it is the only concept for which data are available.",
      :primary_income => "Income per capita from primary market activities, e.g. the sale of labor. Calculated using the fictive currency 'Purchasing Power Standards (PPS)' which is, roughly speaking, a Euro standardized across geography but not across time.",
      # "Primary income of private households (PPS per inhabitant) in a region. The primary distribution of income shows the income of private households generated directly from market transactions, in particular the purchase and sale of factors of production. This includes as the main item the compensation of employees, i.e. income from the sale of labour as a factor of production. Purchasing Power Standards (PPS) are a fictive currency unit that eliminates differences in purchasing power, i.e. different price levels, between countries. [The calculation in PPS is intended to allow the comparison of levels of economic activity of different sized economies irrespective of their price levels. It is less suited for comparisons over time.]",
      :start_year_death_rate => "Start year of time range. For death rate measurements.",
      :end_year_death_rate => "End year of time range. For death rate measurements.",
      :all_causes_death_rate => "Deaths due to all causes of death in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :cancer_death_rate => "Deaths due to cancer (all death caused by a malignant neoplasm) in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :heart_disease_death_rate => "Death due to ischemic heart diseases (all death caused by reduced blood supply to the heart - most are due to 'heart attack') in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :all_accidents_death_rate => "Death due to all kinds of accidents (transport, drowning, fire, ...) in a region. Standardised death rate per 100,000 inhabitants, 3 years average.",
      :transport_accidents_death_rate => "Death due to transport accidents (all kinds of transport (road: car, pedestrian, cyclist, ..; water; air; ...)) in a region. Standardised death rate per 100,000 inhabitants, 3 years average."
    }
  end

  def self.filterables
    [ 'country', 'region', 'year', 'total_population', 'population_density',
      'primary_income', 'start_year_death_rate', 'end_year_death_rate', 
      'all_causes_death_rate', 'cancer_death_rate', 'heart_disease_death_rate',
      'all_accidents_death_rate', 'transport_accidents_death_rate' ]
  end

end
