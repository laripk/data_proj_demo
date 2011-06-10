# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110603123608) do

  create_table "countries", :force => true do |t|
    t.string   "code",        :limit => 2
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["code"], :name => "index_countries_on_code", :unique => true

  create_table "death_rates", :force => true do |t|
    t.integer  "region_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.float    "all_causes"
    t.boolean  "all_causes_provisional"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "cancer"
    t.boolean  "cancer_provisional"
    t.float    "heart_disease"
    t.boolean  "heart_disease_provisional"
    t.float    "all_accidents"
    t.boolean  "all_accidents_provisional"
    t.float    "transport_accidents"
    t.boolean  "transport_accidents_provisional"
  end

  add_index "death_rates", ["region_id", "start_year"], :name => "deaths_by_region_year", :unique => true
  add_index "death_rates", ["region_id"], :name => "index_death_rates_on_region_id"

  create_table "household_incomes", :force => true do |t|
    t.integer  "region_id"
    t.integer  "year"
    t.float    "primary"
    t.boolean  "primary_estimated"
    t.boolean  "primary_break_in_series"
    t.boolean  "primary_see_explan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "household_incomes", ["region_id", "year"], :name => "income_by_region_year", :unique => true
  add_index "household_incomes", ["region_id"], :name => "index_household_incomes_on_region_id"

  create_table "populations", :force => true do |t|
    t.integer  "region_id"
    t.integer  "year"
    t.integer  "total_pop_thous"
    t.boolean  "total_pop_estimated"
    t.boolean  "total_pop_break_in_series"
    t.boolean  "total_pop_see_explan"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "pop_density_perkm2"
  end

  add_index "populations", ["region_id", "year"], :name => "pop_by_region_year", :unique => true
  add_index "populations", ["region_id"], :name => "index_populations_on_region_id"

  create_table "queries", :force => true do |t|
    t.string   "name"
    t.text     "selected_fields"
    t.text     "selected_filters"
    t.boolean  "is_active",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "code",        :limit => 20
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  add_index "regions", ["code"], :name => "index_regions_on_code", :unique => true

  create_view "vwa_regions", "SELECT r.id AS region_id, r.code AS region_code, r.description AS region_description, c.id AS country_id, c.code AS country_code, c.description AS country_description FROM (regions r LEFT JOIN countries c ON ((r.country_id = c.id)));", :force => true do |v|
    v.column :region_id
    v.column :region_code
    v.column :region_description
    v.column :country_id
    v.column :country_code
    v.column :country_description
  end

  create_view "vwa_yearlies", "(SELECT p.region_id, p.year, p.total_pop_thous AS total_population, p.pop_density_perkm2 AS population_density, h.\"primary\" AS primary_income FROM (populations p JOIN household_incomes h ON (((p.region_id = h.region_id) AND (p.year = h.year)))) UNION SELECT h.region_id, h.year, p.total_pop_thous AS total_population, p.pop_density_perkm2 AS population_density, h.\"primary\" AS primary_income FROM (populations p RIGHT JOIN household_incomes h ON (((p.region_id = h.region_id) AND (p.year = h.year)))) WHERE (p.id IS NULL)) UNION SELECT p.region_id, p.year, p.total_pop_thous AS total_population, p.pop_density_perkm2 AS population_density, h.\"primary\" AS primary_income FROM (populations p LEFT JOIN household_incomes h ON (((p.region_id = h.region_id) AND (p.year = h.year)))) WHERE (h.id IS NULL);", :force => true do |v|
    v.column :region_id
    v.column :year
    v.column :total_population
    v.column :population_density
    v.column :primary_income
  end

  create_view "vwb_combineds", "(SELECT y.region_id, y.year, y.total_population, y.population_density, y.primary_income, d.start_year AS start_year_death_rate, d.end_year AS end_year_death_rate, d.all_causes AS all_causes_death_rate, d.cancer AS cancer_death_rate, d.heart_disease AS heart_disease_death_rate, d.all_accidents AS all_accidents_death_rate, d.transport_accidents AS transport_accidents_death_rate FROM (vwa_yearlies y JOIN death_rates d ON (((y.region_id = d.region_id) AND ((y.year >= d.start_year) AND (y.year <= d.end_year))))) UNION SELECT y.region_id, y.year, y.total_population, y.population_density, y.primary_income, d.start_year AS start_year_death_rate, d.end_year AS end_year_death_rate, d.all_causes AS all_causes_death_rate, d.cancer AS cancer_death_rate, d.heart_disease AS heart_disease_death_rate, d.all_accidents AS all_accidents_death_rate, d.transport_accidents AS transport_accidents_death_rate FROM (vwa_yearlies y LEFT JOIN death_rates d ON (((y.region_id = d.region_id) AND ((y.year >= d.start_year) AND (y.year <= d.end_year))))) WHERE (d.id IS NULL)) UNION SELECT d.region_id, y.year, y.total_population, y.population_density, y.primary_income, d.start_year AS start_year_death_rate, d.end_year AS end_year_death_rate, d.all_causes AS all_causes_death_rate, d.cancer AS cancer_death_rate, d.heart_disease AS heart_disease_death_rate, d.all_accidents AS all_accidents_death_rate, d.transport_accidents AS transport_accidents_death_rate FROM (vwa_yearlies y RIGHT JOIN death_rates d ON (((y.region_id = d.region_id) AND ((y.year >= d.start_year) AND (y.year <= d.end_year))))) WHERE (y.year IS NULL);", :force => true do |v|
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

  create_view "vwc_all_combineds", "SELECT m.region_id, m.year, m.total_population, m.population_density, m.primary_income, m.start_year_death_rate, m.end_year_death_rate, m.all_causes_death_rate, m.cancer_death_rate, m.heart_disease_death_rate, m.all_accidents_death_rate, m.transport_accidents_death_rate, r.region_code, r.region_description, r.country_code, r.country_description FROM (vwa_regions r RIGHT JOIN vwb_combineds m ON ((r.region_id = m.region_id)));", :force => true do |v|
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
