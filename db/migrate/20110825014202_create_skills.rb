class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
      t.string :description_en
      t.string :description_vi

      t.timestamps
    end
  end

  def self.down
    drop_table :skills
  end
end
