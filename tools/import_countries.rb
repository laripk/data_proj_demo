require 'csv'

# Note: this assumes that import_regions
# has already been done
class CountryImporter
  def self.grab_country_data
		countrytbl = CSV.table("#{RAILS_ROOT}/data/geo_cc.dic")
		
		countrytbl.each do |row| 
		  vals = {}
			vals[:code] = row[:code]
			vals[:description] = row[:description].to_s.
			                       force_encoding("ISO-8859-1").encode("UTF-8")
			country = Country.create!(vals)
			regions = Region.where("code like '#{vals[:code]}%'")
			regions.each do |region|
			  region.country = country
			  region.save
		  end
		end
		[Country.count, Region.count(:country_id)]
  end
end

# NOTE: A LOT OF THE FUNKY CODES AT THE END OF THE REGIONS TABLE PLUS MOST OF THE AGGREGATES MIXED INTO THE MIDDLE HAD FALSE POSITIVE MATCHES ON COUNTRIES AND HAD TO BE HAND EDITED TO REMOVE THE COUNTRY INFO

=begin
# TO RUN THIS:
$ rake db:reset
rake db:data:load
rails console

require "#{RAILS_ROOT}/tools/import_countries"
tbl = CountryImporter.grab_country_data

# stray things that were helpful along the way
> 

=end
