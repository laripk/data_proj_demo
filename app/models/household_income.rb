# == Schema Information
# Schema version: 20110528005942
#
# Table name: household_incomes
#
#  id                      :integer(4)      not null, primary key
#  region_id               :integer(4)
#  year                    :integer(4)
#  primary                 :float
#  primary_estimated       :boolean(1)
#  primary_break_in_series :boolean(1)
#  primary_see_explan      :boolean(1)
#  created_at              :datetime
#  updated_at              :datetime
#

class HouseholdIncome < ActiveRecord::Base
  attr_accessible :year, :primary, :primary_estimated, 
                  :primary_break_in_series, :primary_see_explan

  belongs_to :region
  
  validates :region_id, :presence => true
  validates :year,      :presence => true
  
  def self.describe
    descriptions = {
      :household_incomes => "Household Income information by region. Purchasing Power Standards (PPS) are a fictive currency unit that eliminates differences in purchasing power, i.e. different price levels, between countries. Thus, the same nominal aggregate in two countries with different price levels may result in different amounts of purchasing power. Figures expressed in Purchasing Power Standards are derived from figures expressed in national currency by using Purchasing Power Parities (PPP) as conversion factors. These parities are obtained as a weighted average of relative price ratios in respect to a homogeneous basket of goods and services, both comparable and representative for each country. They are fixed in a way that makes the average purchasing power of one Euro in the European Union equal to one PPS. The calculation of GDP in PPS is intended to allow the comparison of levels of economic activity of different sized economies irrespective of their price levels. It is less suited for comparisons over time.",
      :primary => "Primary income of private households (PPS (Purchasing Power Standards) per inhabitant) in a region. The primary distribution of income shows the income of private households generated directly from market transactions, in particular the purchase and sale of factors of production. This includes as the main item the compensation of employees, i.e. income from the sale of labour as a factor of production. Private households can also receive income on assets, particularly interest, dividends and rents. Then there is also income from net operating surplus and self-employment. Interest and rents payable are recorded as negative items for households. The balance of all these transactions is known as the primary income of private households."
    }
  end
end
