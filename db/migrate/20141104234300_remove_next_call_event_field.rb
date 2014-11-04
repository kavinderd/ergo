class RemoveNextCallEventField < ActiveRecord::Migration
  def up
    remove_column :events, :next_call
  end

  def down
    add_column :events, :next_call, :datetime
  end
end
