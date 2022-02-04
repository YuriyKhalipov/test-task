class RemoveFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :last_name, :string
    remove_column :orders, :first_name, :string
    remove_column :orders, :patronymic, :string
    remove_column :orders, :phone, :string
    remove_column :orders, :email, :string
  end
end
