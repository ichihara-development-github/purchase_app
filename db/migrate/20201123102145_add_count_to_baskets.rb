class AddCountToBaskets < ActiveRecord::Migration[5.1]
  def change
    add_column :baskets, :count, :integer
    add_column :purchases, :count, :integer
    add_column :products, :count, :integer
  end
end
