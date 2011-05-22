require 'csv'

class RegionImporter

	def self.grab_region_data
		inputfile = "#{RAILS_ROOT}/data/geo.dic"
		rdata = CSV.table(inputfile, :col_sep => "\t") # encoding is ASCII-8BIT

		# fixed = rdata.to_csv.force_encoding("UTF-8")
		# fixedfile = "#{RAILS_ROOT}/data/geo_fixed.dic"
		# File.open(fixedfile, 'w', :encoding => "UTF-8") {|f| f << fixed }
		# 
		# rdata = CSV.table(fixedfile)
		    
		rdata.by_row!.each do |row|
			c = row[:code].to_s.force_encoding("ISO-8859-1")
			# puts c
			c = c.encode("UTF-8")
			d = row[:description].to_s.force_encoding("ISO-8859-1")
			# puts d
			d = d.encode("UTF-8")
			Region.create!(:code => c, :description => d)
		end
	end

end

# HOW I USED THIS
# $ rails console
# > require "#{RAILS_ROOT}/tools/import_region"
# > tbl = RegionImporter.grab_region_data


# EXTRACT THE COUNTRY CODE ROWS
# > ccc = tbl.select{|row| row[:code].length==2 }
# > cct = CSV::Table.new(ccc)
# > File.open("#{RAILS_ROOT}/data/geo_cc.dic", 'w', :encoding => "ASCII-8BIT") {|f| f << cct.to_csv }
# AND HERE I EDITED THE COUNTRY CODE FILE TO ONLY HAVE COUNTRY CODES

