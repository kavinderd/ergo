class AddNextCallFieldToEvents < ActiveRecord::Migration
  def up
    add_column :events, :next_call, :datetime
  end

  def down
    remove_column :events, :next_call
  end
end
