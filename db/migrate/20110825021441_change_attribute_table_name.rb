class ChangeAttributeTableName < ActiveRecord::Migration
  def self.up
    drop_table :attributes
    create_table(:experiences) do |t|
      t.integer :skill_id
      t.integer :profile_id

      t.timestamps
    end
  end

  def self.down
    drop_table :experiences
    create_table :attributes do |t|
      t.integer :skill_id
      t.integer :profile_id

      t.timestamps
    end
  end
end
