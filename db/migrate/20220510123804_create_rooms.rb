class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.references :campus, null: false, foreign_key: true
      t.integer :room_type, default: 0
      t.integer :status, default: 0
      t.integer :capacity

      t.timestamps
    end
  end
end
