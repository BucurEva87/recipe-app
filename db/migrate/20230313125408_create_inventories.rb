class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
