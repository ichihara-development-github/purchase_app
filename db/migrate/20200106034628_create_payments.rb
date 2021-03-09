class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
    t.references :user, foreign_key: true
    t.string :currency
    t.string :payments, :email
    t.string :payments, :description
    t.integer :payments, :customer_id
    t.date :payments, :payment_date
    t.integer :payments, :charge_id
    t.integer:payments, :commission
    t.integer :payments, :profit_after_subtract_commission

      t.timestamps
    end
  end
end
