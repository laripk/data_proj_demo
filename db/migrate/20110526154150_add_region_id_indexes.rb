class AddRegionIdIndexes < ActiveRecord::Migration
  def self.up
    add_index :populations, :region_id
    add_index :household_incomes, :region_id
    add_index :death_rates, :region_id
  end

  def self.down
    remove_index :populations, :region_id
    remove_index :household_incomes, :region_id
    remove_index :death_rates, :region_id
  end
end
