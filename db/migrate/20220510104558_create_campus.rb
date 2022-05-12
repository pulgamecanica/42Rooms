class CreateCampus < ActiveRecord::Migration[7.0]
  def change
    create_table :campus do |t|
      t.string :name
      t.string :country
      t.string :language
      t.text :address

      t.timestamps
    end
  end
end
