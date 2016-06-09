class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.references :menu, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
