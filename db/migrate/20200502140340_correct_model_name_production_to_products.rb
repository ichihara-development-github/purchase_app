class CorrectModelNameProductionToProducts < ActiveRecord::Migration[5.0]
  def change
    rename_table :productions, :products
  end
end
