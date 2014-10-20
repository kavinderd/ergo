class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :count
      t.hstore :data
      t.timestamps
    end
  end
end
