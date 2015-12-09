class AddDisplayNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :display_name, :string
  end
end
