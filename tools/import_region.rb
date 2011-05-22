require 'csv'

class RegionImporter
	
	def self.load_countries
		countrytbl = CSV.table("#{RAILS_ROOT}/data/geo_cc.dic")
		countries = {}
		countrytbl.each do |row| 
			countries[row[:code]] = row[:description].to_s.
			                           force_encoding("ISO-8859-1").encode("UTF-8")
		end
		countries		
	end

	def self.grab_region_data
		countries = load_countries
		
		inputfile = "#{RAILS_ROOT}/data/geo.dic"
		rdata = CSV.table(inputfile, :col_sep => "\t") # encoding is ASCII-8BIT

		rdata.by_row!.each do |row|
			c = row[:code].to_s.force_encoding("ISO-8859-1")
			# puts c
			c = c.encode("UTF-8")
			d = row[:description].to_s.force_encoding("ISO-8859-1")
			# puts d
			d = d.encode("UTF-8")
			if c.length > 2 && countries.key?(c[0..1])
				d = "#{countries[c[0..1]]} - #{d}"
			end
			Region.create!(:code => c, :description => d)
		end
	end

end

# HOW I USED THIS
# $ rails console
# > require "#{RAILS_ROOT}/tools/import_region"
# > tbl = RegionImporter.grab_region_data


# EXTRACTED THE COUNTRY CODE ROWS
# > ccc = tbl.select{|row| row[:code].length==2 }
# > cct = CSV::Table.new(ccc)
# > File.open("#{RAILS_ROOT}/data/geo_cc.dic", 'w', :encoding => "ASCII-8BIT") {|f| f << cct.to_csv }
# AND THEN I EDITED THE COUNTRY CODE FILE TO ONLY HAVE COUNTRY CODES

