class RemoveColumnDiscription < ActiveRecord::Migration[5.0]
  def change
    remove_column :stores, :discription, :string
    add_column :stores, :description, :string
  end
end
