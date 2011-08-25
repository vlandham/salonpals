class CreateSkillSets < ActiveRecord::Migration
  def self.up
    create_table :skill_sets do |t|
      t.integer :skill_id
      t.integer :skill_category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :skill_sets
  end
end
