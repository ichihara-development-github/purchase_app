class CorrectPurchaseTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :purchaceds, :purchases
  end
end
