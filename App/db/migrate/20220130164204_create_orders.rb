class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :last_name
      t.string :first_name
      t.string :patronymic
      t.string :phone
      t.string :email
      t.decimal :weight, precision: 8, scale: 3
      t.integer :length
      t.integer :width
      t.integer :height
      t.decimal :distance, precision: 7, scale: 2
      t.string :origin_location
      t.string :destination_location
      t.decimal :price, precision: 12, scale: 2

      t.timestamps
    end
  end
end
