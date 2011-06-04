class CreateQueries < ActiveRecord::Migration
  def self.up
    create_table :queries do |t|
      t.string  :name
      t.text    :selected_fields
      t.text    :selected_filters
      t.boolean :is_active
      
      t.timestamps
    end
  end

  def self.down
    drop_table :queries
  end
end
