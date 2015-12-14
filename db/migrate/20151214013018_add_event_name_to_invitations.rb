class AddEventNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :event_name, :string
  end
end
