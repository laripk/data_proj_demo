class CreatePopulations < ActiveRecord::Migration
  def self.up
    create_table :populations do |t|
      t.integer :region_id
      t.integer :year
      t.integer :total_pop_thous
      t.boolean :total_pop_estimated
      t.boolean :total_pop_break_in_series
      t.boolean :total_pop_see_explan

      t.timestamps
    end
    add_index :populations, [:region_id, :year], 
              :unique => true, 
              :name => 'pop_by_region_year'
  end

  def self.down
    remove_index :populations, :name => :pop_by_region_year
    drop_table :populations
  end
end
