class AddFormattedStringsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_description, :string
    add_column :events, :end_description, :string
  end
end
