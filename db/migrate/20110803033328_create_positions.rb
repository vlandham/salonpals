class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.integer :profile_id
      t.string :title
      t.string :location
      t.date :date_start
      t.date :date_end
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :positions
  end
end
