class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.float :star
      t.string :comment
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
