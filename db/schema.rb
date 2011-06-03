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

ActiveRecord::Schema.define(:version => 20110602111108) do

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

  create_view "vwa_regions", "select `r`.`id` AS `region_id`,`r`.`code` AS `region_code`,`r`.`description` AS `region_description`,`c`.`id` AS `country_id`,`c`.`code` AS `country_code`,`c`.`description` AS `country_description` from (`regions` `r` left join `countries` `c` on((`r`.`country_id` = `c`.`id`)))", :force => true do |v|
    v.column :region_id
    v.column :region_code
    v.column :region_description
    v.column :country_id
    v.column :country_code
    v.column :country_description
  end

  create_view "vwa_yearlies", "select `p`.`region_id` AS `region_id`,`p`.`year` AS `year`,`p`.`total_pop_thous` AS `total_population`,`p`.`pop_density_perkm2` AS `population_density`,`h`.`primary` AS `primary_income` from (`populations` `p` join `household_incomes` `h` on(((`p`.`region_id` = `h`.`region_id`) and (`p`.`year` = `h`.`year`)))) union select `h`.`region_id` AS `region_id`,`h`.`year` AS `year`,`p`.`total_pop_thous` AS `total_population`,`p`.`pop_density_perkm2` AS `population_density`,`h`.`primary` AS `primary_income` from (`household_incomes` `h` left join `populations` `p` on(((`p`.`region_id` = `h`.`region_id`) and (`p`.`year` = `h`.`year`)))) where isnull(`p`.`id`) union select `p`.`region_id` AS `region_id`,`p`.`year` AS `year`,`p`.`total_pop_thous` AS `total_population`,`p`.`pop_density_perkm2` AS `population_density`,`h`.`primary` AS `primary_income` from (`populations` `p` left join `household_incomes` `h` on(((`p`.`region_id` = `h`.`region_id`) and (`p`.`year` = `h`.`year`)))) where isnull(`h`.`id`)", :force => true do |v|
    v.column :region_id
    v.column :year
    v.column :total_population
    v.column :population_density
    v.column :primary_income
  end

  create_view "vwb_combineds", "select `y`.`region_id` AS `region_id`,`y`.`year` AS `year`,`y`.`total_population` AS `total_population`,`y`.`population_density` AS `population_density`,`y`.`primary_income` AS `primary_income`,`d`.`start_year` AS `start_year_death_rate`,`d`.`end_year` AS `end_year_death_rate`,`d`.`all_causes` AS `all_causes_death_rate`,`d`.`cancer` AS `cancer_death_rate`,`d`.`heart_disease` AS `heart_disease_death_rate`,`d`.`all_accidents` AS `all_accidents_death_rate`,`d`.`transport_accidents` AS `transport_accidents_death_rate` from (`vwa_yearlies` `y` join `death_rates` `d` on(((`y`.`region_id` = `d`.`region_id`) and (`y`.`year` between `d`.`start_year` and `d`.`end_year`)))) union select `y`.`region_id` AS `region_id`,`y`.`year` AS `year`,`y`.`total_population` AS `total_population`,`y`.`population_density` AS `population_density`,`y`.`primary_income` AS `primary_income`,`d`.`start_year` AS `start_year`,`d`.`end_year` AS `end_year`,`d`.`all_causes` AS `all_causes`,`d`.`cancer` AS `cancer`,`d`.`heart_disease` AS `heart_disease`,`d`.`all_accidents` AS `all_accidents`,`d`.`transport_accidents` AS `transport_accidents` from (`vwa_yearlies` `y` left join `death_rates` `d` on(((`y`.`region_id` = `d`.`region_id`) and (`y`.`year` between `d`.`start_year` and `d`.`end_year`)))) where isnull(`d`.`id`) union select `d`.`region_id` AS `region_id`,`y`.`year` AS `year`,`y`.`total_population` AS `total_population`,`y`.`population_density` AS `population_density`,`y`.`primary_income` AS `primary_income`,`d`.`start_year` AS `start_year`,`d`.`end_year` AS `end_year`,`d`.`all_causes` AS `all_causes`,`d`.`cancer` AS `cancer`,`d`.`heart_disease` AS `heart_disease`,`d`.`all_accidents` AS `all_accidents`,`d`.`transport_accidents` AS `transport_accidents` from (`death_rates` `d` left join `vwa_yearlies` `y` on(((`y`.`region_id` = `d`.`region_id`) and (`y`.`year` between `d`.`start_year` and `d`.`end_year`)))) where isnull(`y`.`year`)", :force => true do |v|
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

  create_view "vwc_all_combineds", "select `m`.`region_id` AS `region_id`,`m`.`year` AS `year`,`m`.`total_population` AS `total_population`,`m`.`population_density` AS `population_density`,`m`.`primary_income` AS `primary_income`,`m`.`start_year_death_rate` AS `start_year_death_rate`,`m`.`end_year_death_rate` AS `end_year_death_rate`,`m`.`all_causes_death_rate` AS `all_causes_death_rate`,`m`.`cancer_death_rate` AS `cancer_death_rate`,`m`.`heart_disease_death_rate` AS `heart_disease_death_rate`,`m`.`all_accidents_death_rate` AS `all_accidents_death_rate`,`m`.`transport_accidents_death_rate` AS `transport_accidents_death_rate`,`r`.`region_code` AS `region_code`,`r`.`region_description` AS `region_description`,`r`.`country_code` AS `country_code`,`r`.`country_description` AS `country_description` from (`vwb_combineds` `m` left join `vwa_regions` `r` on((`r`.`region_id` = `m`.`region_id`)))", :force => true do |v|
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
