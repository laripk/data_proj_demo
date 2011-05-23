require 'csv'

# Note: this assumes that import_region 
# has already been done
class TotalPopulationImporter
  def self.grab_total_pop_data
    inputfile = "#{RAILS_ROOT}/data/tgs00001.tsv"
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
        elsif /\d+/ =~ value
          value = value.to_i
        else
          raise "unexpected value found in #{row[0]}, #{i}"
        end
        estimated = flags.include?('s')
        break_in_series = flags.include?('b')
        see_explan = flags.include?('i')

        region.populations.create!(:year => year,
            :total_pop_thous => value, 
            :total_pop_estimated => estimated, 
            :total_pop_break_in_series => break_in_series, 
            :total_pop_see_explan => see_explan)
      end #cell loop
    end #row loop
    Population.count
  end
end

=begin
# TO RUN THIS:
$ rake db:reset
rake db:data:load
rails console

> require "#{RAILS_ROOT}/tools/import_total_population"
tbl = TotalPopulationImporter.grab_total_pop_data

# stray things that were helpful along the way
> 


=end
