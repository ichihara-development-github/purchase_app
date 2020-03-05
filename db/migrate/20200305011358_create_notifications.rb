class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|

      t.integer :active_user_id
      t.integer :passive_user_id
      t.integer :production_id
      t.integer :comment_id
      t.boolean :checked, default: false
      t.string :action
      t.timestamps
    end
  end
end
