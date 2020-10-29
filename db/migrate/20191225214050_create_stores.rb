class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :discription
      t.string :category
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
