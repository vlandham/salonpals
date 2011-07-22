class ReallyChangePostDescriptionToText < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.remove :description
      t.text :description
    end    
  end

  def self.down
    change_table :posts do |t|
      t.remove :description
      t.string :description
    end    
  end
end
