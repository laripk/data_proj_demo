require 'csv'

# Note: this assumes that import_deaths_all_causes 
# has already been done
class DeathsTransportAccidentsImporter
  def self.grab_transport_accidents_death_data
    inputfile = "#{RAILS_ROOT}/data/tgs00061.tsv"
		data = CSV.read(inputfile, :col_sep => "\t") 

    header = ["geo"]
    data[0][1..-1].each do |v| 
      header << v.strip.split('_').map{|y| y.to_i }
    end
    
    data[1..-1].each do |row|
      puts row[0]
      region = Region.find_by_code(row[0])
      unless region
        region = Region.create!(:code => row[0],
                                :description => "#{row[0]} Region")
      end
      row[1..-1].each_with_index do |cell, i|
        start_year, end_year = header[i+1]
        value, flags = cell.split(/ /, -1)
        # puts "'#{value}', '#{flags}'"
        
        if value == ':'
          value = nil
        elsif /^[0-9\.]+$/ =~ value
          value = value.to_f
        else
          raise "unexpected value found in #{row[0]}, #{i}"
        end
        provisional = flags.include?('p')
        
        rate = DeathRate.find_by_region_id_and_start_year(region, start_year)
        if rate
          if end_year != rate.end_year
            raise "end_year mismatch for region #{region.id}, start #{start_year}"
          end
          rate.transport_accidents = value
          rate.transport_accidents_provisional = provisional
          rate.save
        else
          region.death_rates.create!(:start_year => start_year,
                                     :end_year => end_year,
                                     :transport_accidents => value,
                                     :transport_accidents_provisional => provisional)
        end
      end #cell loop
    end #row loop
    DeathRate.count
  end
end

=begin
# TO RUN THIS:
$ rake db:reset
rake db:data:load
rails console

require "#{RAILS_ROOT}/tools/import_deaths_transport_accidents"
tbl = DeathsTransportAccidentsImporter.grab_transport_accidents_death_data

# stray things that were helpful along the way
> 

=end
