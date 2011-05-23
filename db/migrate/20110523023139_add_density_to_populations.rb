class AddDensityToPopulations < ActiveRecord::Migration
  def self.up
    add_column :populations, :pop_density_perkm2, :float
  end

  def self.down
    remove_column :populations, :pop_density_perkm2
  end
end
