class CreateLinenonces < ActiveRecord::Migration[5.1]
  def change
    create_table :linenonces do |t|
      t.integer :nonce
    
      t.timestamps
    end
  end
end
