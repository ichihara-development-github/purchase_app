class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :introduce
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
