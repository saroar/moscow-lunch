class CreateItemAssociations < ActiveRecord::Migration
  def change
    create_table :item_associations do |t|
      t.references :item, index: true, foreign_key: true
      t.references :item_association, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
