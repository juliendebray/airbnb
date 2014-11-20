class AddCoordinatesToApartment < ActiveRecord::Migration
  def change
    add_column :apartments, :latitude, :float
    add_column :apartments, :longitude, :float
  end
end
