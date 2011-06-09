class CreateVwaRegions < ActiveRecord::Migration
  def self.up
    regions_sql = <<-SQL
      select r.id as region_id, r.code as region_code, 
        r.description as region_description,
        c.id as country_id, c.code as country_code, 
        c.description as country_description
      from regions r left outer join countries c
        on r.country_id=c.id
    SQL
    create_view :vwa_regions, regions_sql do |v|
      v.column :region_id
      v.column :region_code
      v.column :region_description
      v.column :country_id
      v.column :country_code
      v.column :country_description
    end
  end

  def self.down
    drop_view :vwa_regions
  end
end
