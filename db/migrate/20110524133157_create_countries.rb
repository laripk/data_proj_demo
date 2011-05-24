class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :code, :limit => 2 # rats! it turns out there are a few countries hiding in the mix with three letter codes. Not bothering with them now - they're not important.
      t.string :description

      t.timestamps
    end
    add_index :countries, :code, :unique => true
    add_column :regions, :country_id, :integer
  end

  def self.down
    remove_column :regions, :country_id
    remove_index :countries, :code
    drop_table :countries
  end
end
