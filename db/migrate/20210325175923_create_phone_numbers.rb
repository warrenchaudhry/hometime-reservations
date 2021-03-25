class CreatePhoneNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :phone_numbers do |t|
      t.references :guest
      t.string :number

      t.timestamps
    end
  end
end
