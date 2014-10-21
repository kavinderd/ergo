class AddSentAtToTrigger < ActiveRecord::Migration
  def up
    add_column :triggers, :sent_at, :datetime
  end

  def down
    remove_column :triggers, :sent_at
  end
end
