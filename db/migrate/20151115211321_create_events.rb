class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :public
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_index :events, [:user_id, :start_time]
  end
end
