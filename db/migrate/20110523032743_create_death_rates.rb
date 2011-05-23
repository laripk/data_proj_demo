class CreateDeathRates < ActiveRecord::Migration
  def self.up
    create_table :death_rates do |t|
      t.integer :region_id
      t.integer :start_year
      t.integer :end_year
      t.float :all_causes
      t.boolean :all_causes_provisional

      t.timestamps
    end
    add_index :death_rates, [:region_id, :start_year], 
              :unique => true,
              :name => 'deaths_by_region_year'
  end

  def self.down
    remove_index :death_rates, :name => :deaths_by_region_year
    drop_table :death_rates
  end
end
