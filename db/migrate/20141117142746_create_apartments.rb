class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.references :user, index: true
      t.string :address
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
