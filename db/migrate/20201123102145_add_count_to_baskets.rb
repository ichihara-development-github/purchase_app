class AddCountToBaskets < ActiveRecord::Migration[5.1]
  def change
    add_column :baskets, :count, :integer,  default: 1
    add_column :purchases, :count, :integer,  default: 5
    add_column :products, :count, :integer
  end
end
