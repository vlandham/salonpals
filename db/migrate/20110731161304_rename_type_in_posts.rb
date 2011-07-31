class RenameTypeInPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.remove :type
      t.string :kind
    end    
  end

  def self.down
    change_table :posts do |t|
      t.remove :kind
      t.string :type
    end    
  end
end
