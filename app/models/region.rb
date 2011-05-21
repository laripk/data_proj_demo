# == Schema Information
# Schema version: 20110521232440
#
# Table name: regions
#
#  id          :integer         not null, primary key
#  code        :string(20)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Region < ActiveRecord::Base
  attr_accessor :code, :description # for now, because I'm importing
end
