# == Schema Information
# Schema version: 20110601234511
#
# Table name: vwa_yearlies
#
#  region_id          :integer(4)
#  year               :integer(4)
#  total_population   :integer(4)
#  population_density :float
#  primary_income     :float
#

class VwaYearly < ActiveRecord::Base
  before_save    { false }
  before_destroy { false }
end
