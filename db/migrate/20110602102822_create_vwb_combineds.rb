class CreateVwbCombineds < ActiveRecord::Migration
  def self.up
    # ActiveRecord::SchemaDumper.view_creation_order << :vwa_yearlies
    combineds_sql = <<-SQL
      select y.region_id, y.year, y.total_population, y.population_density, y.primary_income,
      	d.start_year as start_year_death_rate, d.end_year as end_year_death_rate,
      	d.all_causes as all_causes_death_rate, d.cancer as cancer_death_rate,
      	d.heart_disease as heart_disease_death_rate, d.all_accidents as all_accidents_death_rate,
      	d.transport_accidents as transport_accidents_death_rate
      from vwa_yearlies y inner join death_rates d
      	on y.region_id=d.region_id and y.year between d.start_year and d.end_year
      union
      select y.region_id, y.year, y.total_population, y.population_density, y.primary_income,
        d.start_year, d.end_year, d.all_causes, d.cancer, d.heart_disease, 
        d.all_accidents, d.transport_accidents
      from vwa_yearlies y left outer join death_rates d
      	on y.region_id=d.region_id and y.year between d.start_year and d.end_year
      where d.id is null
      union
      select d.region_id, y.year, y.total_population, y.population_density, y.primary_income,
        d.start_year, d.end_year, d.all_causes, d.cancer, d.heart_disease, 
        d.all_accidents, d.transport_accidents
      from vwa_yearlies y right outer join death_rates d
      	on y.region_id=d.region_id and y.year between d.start_year and d.end_year
      where y.year is null
    SQL
    create_view :vwb_combineds, combineds_sql do |v|
      v.column :region_id
      v.column :year
      v.column :total_population
      v.column :population_density
      v.column :primary_income
      v.column :start_year_death_rate
      v.column :end_year_death_rate
      v.column :all_causes_death_rate
      v.column :cancer_death_rate
      v.column :heart_disease_death_rate
      v.column :all_accidents_death_rate
      v.column :transport_accidents_death_rate
    end
  end

  def self.down
    drop_view :vwb_combineds
    # ActiveRecord::SchemaDumper.view_creation_order.delete :vwa_yearlies
  end
end
