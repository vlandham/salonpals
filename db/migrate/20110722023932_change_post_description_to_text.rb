class ChangePostDescriptionToText < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.remove :description
      t.text :description
    end
  end

  def self.down
    change_table :profiles do |t|
      t.remove :description
      t.string :description
    end
  end
end
