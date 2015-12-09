class AddDisplayNameToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :display_name, :string
  end
end
