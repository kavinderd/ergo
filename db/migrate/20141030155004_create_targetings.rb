class CreateTargetings < ActiveRecord::Migration
  def change
    create_table :targetings do |t|
      t.integer :trigger_id
      t.integer :client_id
      t.timestamps
    end
  end
end
