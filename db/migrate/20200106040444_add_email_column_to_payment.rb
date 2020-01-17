class AddEmailColumnToPayment < ActiveRecord::Migration[5.0]
  def change
    add_column :payments, :email, :string
  end
end
