class AddHeartDiseaseDeathsToDeathRates < ActiveRecord::Migration
  def self.up
    add_column :death_rates, :heart_disease, :float
    add_column :death_rates, :heart_disease_provisional, :boolean
  end

  def self.down
    remove_column :death_rates, :heart_disease_provisional
    remove_column :death_rates, :heart_disease
  end
end
