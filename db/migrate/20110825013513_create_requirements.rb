class CreateRequirements < ActiveRecord::Migration
  def self.up
    create_table :requirements do |t|
      t.integer :skill_id
      t.integer :post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :requirements
  end
end
