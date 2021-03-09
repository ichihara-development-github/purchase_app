class RenameModel < ActiveRecord::Migration[5.0]
  def change
    rename_column :baskets, :production_id, :product_id
    rename_column :comments, :production_id, :product_id
    rename_column :purchaceds, :production_id, :product_id
    rename_column :notifications, :production_id, :product_id
  end
end
