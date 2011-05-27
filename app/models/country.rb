# == Schema Information
# Schema version: 20110524133157
#
# Table name: countries
#
#  id          :integer         not null, primary key
#  code        :string(2)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Country < ActiveRecord::Base
	attr_accessible :code, :description 
	
	validates :code,        :presence => true
	validates :description, :presence => true
	
  has_many :regions
  
  def countries_used
    warn "not implemented"
  end
end
