class AddLongLatToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :latitude, :float
    add_column :posts, :longitude, :float
  end

  def self.down
    remove_column :posts, :longitude
    remove_column :posts, :latitude
  end
end
