class CreateHouseholdIncomes < ActiveRecord::Migration
  def self.up
    create_table :household_incomes do |t|
      t.integer :region_id
      t.integer :year
      t.float :primary
      t.boolean :primary_estimated
      t.boolean :primary_break_in_series
      t.boolean :primary_see_explan

      t.timestamps
    end
    add_index :household_incomes, [:region_id, :year], 
              :unique => true, 
              :name => 'income_by_region_year'
  end

  def self.down
    remove_index :household_incomes, :name => :income_by_region_year
    drop_table :household_incomes
  end
end
