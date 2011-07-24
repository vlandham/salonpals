class AddWorkflowStateToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :workflow_state, :string
  end

  def self.down
    remove_column :posts, :workflow_state
  end
end
