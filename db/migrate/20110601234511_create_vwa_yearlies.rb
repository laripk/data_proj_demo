class CreateVwaYearlies < ActiveRecord::Migration
  def self.up
    yearlies_sql = <<-SQL
      select p.region_id, p.year, 
      	p.total_pop_thous as total_population, p.pop_density_perkm2 as population_density,
      	h.primary as primary_income
      from populations p inner join household_incomes h
      	on p.region_id=h.region_id and p.year=h.year
      union
      select h.region_id, h.year,
      	p.total_pop_thous as total_population, p.pop_density_perkm2 as population_density,
      	h.primary as primary_income
      from populations p right outer join household_incomes h
      	on p.region_id=h.region_id and p.year=h.year
      where p.id is null	
      union
      select p.region_id, p.year, 
      	p.total_pop_thous as total_population, p.pop_density_perkm2 as population_density,
      	h.primary as primary_income
      from populations p left outer join household_incomes h
      	on p.region_id=h.region_id and p.year=h.year
      where h.id is null
    SQL
    create_view :vwa_yearlies, yearlies_sql do |v|
      v.column :region_id
      v.column :year
      v.column :total_population
      v.column :population_density
      v.column :primary_income
    end
  end

  def self.down
    drop_view :vwa_yearlies
  end
end
