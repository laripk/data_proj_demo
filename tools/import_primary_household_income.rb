require 'csv'

# Note: this assumes that import_region 
# has already been done
class PrimaryHouseholdIncomeImporter
  def self.grab_primary_hhincome_data
    inputfile = "#{RAILS_ROOT}/data/tgs00036.tsv"
		data = CSV.read(inputfile, :col_sep => "\t") 

		header = data[0]
    header[0] = "geo"
    header.each{|v| v.strip! }
    
    data[1..-1].each do |row|
      puts row[0]
      region = Region.find_by_code(row[0])
      unless region
        region = Region.create!(:code => row[0],
                                :description => "#{row[0]} Region")
      end
      row[1..-1].each_with_index do |cell, i|
        year = header[i+1].to_i
        value, flags = cell.split(/ /, -1)
        # puts "'#{value}', '#{flags}'"

        if value == ':'
          value = nil
        elsif /^[0-9\.]+$/ =~ value
          value = value.to_f
        else
          raise "unexpected value found in #{row[0]}, #{i}"
        end
        estimated = flags.include?('e')
        break_in_series = flags.include?('b')
        see_explan = flags.include?('i')

        region.household_incomes.create!(:year => year,
            :primary => value, 
            :primary_estimated => estimated, 
            :primary_break_in_series => break_in_series, 
            :primary_see_explan => see_explan)
      end #cell loop
    end #row loop
    HouseholdIncome.count
  end
end

=begin
# TO RUN THIS:
$ rake db:reset
rake db:data:load
rails console

require "#{RAILS_ROOT}/tools/import_primary_household_income"
tbl = PrimaryHouseholdIncomeImporter.grab_primary_hhincome_data

# stray things that were helpful along the way
> 


=end
