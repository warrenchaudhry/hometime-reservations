class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :guest
      t.date :start_date
      t.date :end_date
      t.integer :nights, default: 0
      t.integer :guests, default: 0
      t.integer :adults, default: 0
      t.integer :children, default: 0
      t.integer :infants, default: 0
      t.string :currency
      t.decimal :payout_price, precision: 8, scale: 2, default: 0
      t.decimal :security_price, precision: 8, scale: 2, default: 0
      t.decimal :total_price, precision: 8, scale: 2, default: 0 
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
