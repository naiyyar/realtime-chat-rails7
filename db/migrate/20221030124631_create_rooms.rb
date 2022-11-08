class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :user_ids, array: true, default: []
      t.timestamps
    end
  end
end
