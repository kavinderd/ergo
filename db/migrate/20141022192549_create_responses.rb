class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :trigger_id
      t.string :event_name
      t.datetime :start_at
      t.datetime :end_at
      t.integer :status, default: 0
      t.integer :category
      t.timestamps
    end
  end
end
