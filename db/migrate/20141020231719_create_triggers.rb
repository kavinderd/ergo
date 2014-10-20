class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.string :event_name
      t.integer :user_id
      t.integer :frequency
      t.integer :threshold
      t.timestamps
    end
  end
end
