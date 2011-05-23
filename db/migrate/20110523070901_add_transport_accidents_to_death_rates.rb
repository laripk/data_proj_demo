class AddTransportAccidentsToDeathRates < ActiveRecord::Migration
  def self.up
    add_column :death_rates, :transport_accidents, :float
    add_column :death_rates, :transport_accidents_provisional, :boolean
  end

  def self.down
    remove_column :death_rates, :transport_accidents_provisional
    remove_column :death_rates, :transport_accidents
  end
end
