class AddActionFieldToTrigger < ActiveRecord::Migration
  def up
    add_column :triggers, :action, :integer
  end
  def down
    remove_column :triggers, :action
  end
end
