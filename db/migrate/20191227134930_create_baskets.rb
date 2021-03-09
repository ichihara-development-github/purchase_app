class CreateBaskets < ActiveRecord::Migration[5.0]
  def change
    create_table :baskets do |t|
      t.references :user, foreign_key: true
      t.references :production

      t.timestamps
    end
  end
end
