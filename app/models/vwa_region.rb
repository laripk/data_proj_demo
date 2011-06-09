# == Schema Information
# Schema version: 20110602094214
#
# Table name: vwa_regions
#
#  region_id           :integer(4)      default(0), not null
#  region_code         :string(20)
#  region_description  :string(255)
#  country_id          :integer(4)      default(0)
#  country_code        :string(2)
#  country_description :string(255)
#

class VwaRegion < ActiveRecord::Base
  before_save    { false }
  before_destroy { false }
end
