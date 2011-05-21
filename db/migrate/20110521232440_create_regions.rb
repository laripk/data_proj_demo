class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :code, :limit => 20
      t.string :description

      t.timestamps
    end
    add_index :regions, :code, :unique => true
  end

  def self.down
    remove_index :regions, :code
    drop_table :regions
  end
end
