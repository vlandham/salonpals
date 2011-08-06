class AddCompanyToPositions < ActiveRecord::Migration
  def self.up
    add_column :positions, :company, :string
  end

  def self.down
    remove_column :positions, :company
  end
end
