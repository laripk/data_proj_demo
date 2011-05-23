require 'csv'

# Note: this assumes that import_region 
# has already been done
class DeathsAllCausesImporter
  def self.grab_all_cause_death_data
    inputfile = "#{RAILS_ROOT}/data/tgs00057.tsv"
		data = CSV.read(inputfile, :col_sep => "\t") 

    header = ["geo"]
    data[0][1..-1].each do |v| 
      header << v.strip.split('_').map{|y| y.to_i }
    end
    # print header
    
    data[1..-1].each do |row|
      puts row[0]
      region = Region.find_by_code(row[0])
      unless region
        region = Region.create!(:code => row[0],
                                :description => "#{row[0]} Region")
      end
      row[1..-1].each_with_index do |cell, i|
        start_year, end_year = header[i+1]
        # print i, header[i+1], cell
        # puts "'#{start_year}', '#{end_year}'"
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
        
        region.death_rates.create!(:start_year => start_year,
            :end_year => end_year,
            :all_causes => value,
            :all_causes_provisional => provisional)
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

> require "#{RAILS_ROOT}/tools/import_deaths_all_causes"
tbl = DeathsAllCausesImporter.grab_all_cause_death_data

# stray things that were helpful along the way
> 

=end
