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

ActiveRecord::Schema.define(:version => 20110601234511) do

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
    t.boolean  "is_active"
    t.text     "query_def"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "queries", ["name"], :name => "index_queries_on_name", :unique => true

  create_table "regions", :force => true do |t|
    t.string   "code",        :limit => 20
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
  end

  add_index "regions", ["code"], :name => "index_regions_on_code", :unique => true

  create_view "v_yearlies", "select `p`.`region_id` AS `region_id`,`p`.`year` AS `year`,`p`.`total_pop_thous` AS `total_population`,`p`.`pop_density_perkm2` AS `population_density`,`h`.`primary` AS `primary_income` from (`populations` `p` join `household_incomes` `h` on(((`p`.`region_id` = `h`.`region_id`) and (`p`.`year` = `h`.`year`)))) union select `h`.`region_id` AS `region_id`,`h`.`year` AS `year`,`p`.`total_pop_thous` AS `total_population`,`p`.`pop_density_perkm2` AS `population_density`,`h`.`primary` AS `primary_income` from (`household_incomes` `h` left join `populations` `p` on(((`p`.`region_id` = `h`.`region_id`) and (`p`.`year` = `h`.`year`)))) where isnull(`p`.`id`) union select `p`.`region_id` AS `region_id`,`p`.`year` AS `year`,`p`.`total_pop_thous` AS `total_population`,`p`.`pop_density_perkm2` AS `population_density`,`h`.`primary` AS `primary_income` from (`populations` `p` left join `household_incomes` `h` on(((`p`.`region_id` = `h`.`region_id`) and (`p`.`year` = `h`.`year`)))) where isnull(`h`.`id`)", :force => true do |v|
    v.column :region_id
    v.column :year
    v.column :total_population
    v.column :population_density
    v.column :primary_income
  end

end
