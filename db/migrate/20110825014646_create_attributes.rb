class CreateAttributes < ActiveRecord::Migration
  def self.up
    create_table :attributes do |t|
      t.integer :skill_id
      t.integer :profile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :attributes
  end
end
