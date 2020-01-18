class AddImageparamsAndSoon < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_image, :string
    add_column :stores, :top_image, :string
    add_column :productions, :main_image, :string
    add_column :productions, :sub_image1, :string
    add_column :productions, :sub_image2, :string
    add_column :productions, :category, :string
  end
end
