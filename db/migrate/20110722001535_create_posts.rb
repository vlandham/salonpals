class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id
      t.string :type
      t.string :description
      t.string :address_street
      t.string :address_city
      t.string :address_state
      t.integer :address_zip
      t.date :date_start
      t.date :date_expire
      t.integer :status
      t.text :requirements

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
