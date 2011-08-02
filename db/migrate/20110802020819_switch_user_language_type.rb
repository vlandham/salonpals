class SwitchUserLanguageType < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :language
      t.string :language
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :language
      t.integer :language
    end
  end
end
