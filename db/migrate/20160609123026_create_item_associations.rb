class CreateItemAssociations < ActiveRecord::Migration
  def change
    create_table :item_associations do |t|
      t.decimal :price
      t.integer :item_id
      t.integer :item_association_id
      t.string  :item_association_type

      t.timestamps null: false
    end
  end
end
