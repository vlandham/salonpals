class CleanUpPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.remove :active
      t.boolean :active, :default => false
      t.remove :status
      t.remove :date_start
      t.datetime :activated_at
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :active
      t.boolean :active
      t.integer :status
      t.remove :activated_at
      t.date :date_start
    end
  end
end
