class CreateVwcAllCombineds < ActiveRecord::Migration
  def self.up
    # ActiveRecord::SchemaDumper.view_creation_order << :vw_regions
    # ActiveRecord::SchemaDumper.view_creation_order << :vw_combineds
    combineds_sql = <<-SQL
      select m.*, r.region_code, r.region_description, r.country_code, r.country_description
      from vwa_regions r right outer join vwb_combineds m
        on r.region_id=m.region_id
    SQL
    create_view :vwc_all_combineds, combineds_sql do |v|
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
      v.column :region_code
      v.column :region_description
      v.column :country_code
      v.column :country_description
    end
  end

  def self.down
    drop_view :vwc_all_combineds
    # ActiveRecord::SchemaDumper.view_creation_order.delete :vwb_combineds
    # ActiveRecord::SchemaDumper.view_creation_order.delete :vwa_regions
  end
end
