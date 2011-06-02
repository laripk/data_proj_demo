class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.string :name
      t.boolean :is_active
      t.text :query_def

      t.timestamps
    end
    add_index :queries, :name, :unique => true
  end

  def self.down
    remove_index :queries, :name
    drop_table :queries
  end
end
