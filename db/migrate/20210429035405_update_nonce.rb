class UpdateNonceAndLineId < ActiveRecord::Migration[5.1]
  def change
    remove_column :linenonces, :nonce, :integer
    add_column :linenonces, :nonce, :string
  end
end
