class CreateSkillCategories < ActiveRecord::Migration
  def self.up
    create_table :skill_categories do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :skill_categories
  end
end
