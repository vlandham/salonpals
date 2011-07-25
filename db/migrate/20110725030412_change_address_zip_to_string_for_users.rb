class ChangeAddressZipToStringForUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :zip_code
      t.string :zip_code
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :zip_code
      t.integer :zip_code
    end
  end
end
