class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :token
      t.integer :user_id
      t.timestamps
    end
  end
end
