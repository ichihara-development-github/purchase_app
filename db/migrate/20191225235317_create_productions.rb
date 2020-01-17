class CreateProductions < ActiveRecord::Migration[5.0]
  def change
    create_table :productions do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :category
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
