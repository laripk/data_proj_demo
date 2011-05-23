class AddCancerDeathsToDeathRates < ActiveRecord::Migration
  def self.up
    add_column :death_rates, :cancer, :float
    add_column :death_rates, :cancer_provisional, :boolean
  end

  def self.down
    remove_column :death_rates, :cancer_provisional
    remove_column :death_rates, :cancer
  end
end
