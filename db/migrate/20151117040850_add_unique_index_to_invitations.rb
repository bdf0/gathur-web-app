class AddUniqueIndexToInvitations < ActiveRecord::Migration
  def change
  		add_index :invitations, [:user_id, :event_id], unique: true
  end
end
