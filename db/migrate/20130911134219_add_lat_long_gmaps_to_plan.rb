class AddLatLongGmapsToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :latitude, :float
    add_column :plans, :longitude,  :float
    add_column :plans, :gmaps, :boolean, :default => false
  end
end
