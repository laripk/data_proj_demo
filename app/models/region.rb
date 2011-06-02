# == Schema Information
# Schema version: 20110528005942
#
# Table name: regions
#
#  id          :integer(4)      not null, primary key
#  code        :string(20)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  country_id  :integer(4)
#

class Region < ActiveRecord::Base
	attr_accessible :code, :description # for now, because I'm importing

	validates :code,        :presence => true
	validates :description, :presence => true
	
	belongs_to :country
	has_many   :populations
	has_many   :death_rates
	has_many   :household_incomes
	
	def regions_used
	  warn "not implemented"
  end
end
