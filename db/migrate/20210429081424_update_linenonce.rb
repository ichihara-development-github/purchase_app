class UpdateLinenonce < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :line_id, :integer
    add_column :users, :line_id, :string
  end
end
