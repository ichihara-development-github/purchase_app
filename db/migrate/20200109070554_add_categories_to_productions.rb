class AddCategoriesToProductions < ActiveRecord::Migration[5.0]
  def change
    add_column :productions, :category, :string
  end
end
