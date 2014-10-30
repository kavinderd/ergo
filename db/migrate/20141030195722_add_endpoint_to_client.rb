class AddEndpointToClient < ActiveRecord::Migration

  def up
    add_column :clients, :endpoint, :string
  end

  def down
    remove_column :clients, :endpoint
  end

end
