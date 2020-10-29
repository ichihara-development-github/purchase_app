class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :introduce
      t.integer :store_id

      t.timestamps
    end
  end
end
