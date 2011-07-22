class FixProfilesUserId < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.remove :user_id_id
      t.integer :user_id
    end
  end

  def self.down
    change_table :profiles do |t|
      t.remove :user_id
      t.integer :user_id_id
    end
  end
end
