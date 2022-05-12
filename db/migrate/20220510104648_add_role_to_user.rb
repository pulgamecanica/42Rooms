class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 0
    add_column :users, :login, :string
    add_reference :users, :campus, null: true, foreign_key: true
  end
end
