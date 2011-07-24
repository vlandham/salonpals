class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :post_id
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :card_type
      t.date :card_expires_on
      t.string :address_street
      t.string :address_city
      t.string :address_state
      t.string :address_zip

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
