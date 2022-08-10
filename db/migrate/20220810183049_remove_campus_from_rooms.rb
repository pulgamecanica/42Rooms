class RemoveCampusFromRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :campus_id, :bigint
  end
end
