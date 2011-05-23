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

ActiveRecord::Schema.define(:version => 20110523061027) do

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
  end

  add_index "death_rates", ["region_id", "start_year"], :name => "deaths_by_region_year", :unique => true

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

  create_table "regions", :force => true do |t|
    t.string   "code",        :limit => 20
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["code"], :name => "index_regions_on_code", :unique => true

end
