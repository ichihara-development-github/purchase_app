class CreateLinenonces < ActiveRecord::Migration[5.1]
  def change
    create_table :linenonces do |t|
      t.integer :nonce
      t.integer :user_id

      t.timestamps
    end
  end
end
