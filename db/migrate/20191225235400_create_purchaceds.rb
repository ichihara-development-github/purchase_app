class CreatePurchaceds < ActiveRecord::Migration[5.0]
  def change
    create_table :purchaceds do |t|
      t.references :user, foreign_key: true
      t.references :production, foreign_key: true

      t.timestamps
    end
  end
end
