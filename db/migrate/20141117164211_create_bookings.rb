class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :apartment, index: true
      t.references :user, index: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
