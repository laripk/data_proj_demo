require 'csv'

# Note: this assumes that import_total_population 
# has already been done
class PopulationDensityImporter
  def self.grab_pop_dens_data
    inputfile = "#{RAILS_ROOT}/data/tgs00024.tsv"
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
        year = header[i].to_i
        value, flags = cell.split(/ /, -1)
        # puts "'#{value}', '#{flags}'"

        if value == ':'
          value = nil
        elsif /\d+/ =~ value
          value = value.to_f
        else
          raise "unexpected value found in #{row[0]}, #{i}"
        end
        unless flags == ""
          raise "unexpected flag found in #{row[0]}, #{i}"
        end
        
        pop = Population.find_by_region_id_and_year(region, year)
        if pop
          pop.pop_density_perkm2 = value
          pop.save
        else
          region.populations.create(:year => year,
                                    :pop_density_perkm2 => value)
        end
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

> require "#{RAILS_ROOT}/tools/import_population_density"
tbl = PopulationDensityImporter.grab_pop_dens_data

# stray things that were helpful along the way
> 


=end
