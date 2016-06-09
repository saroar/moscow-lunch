class CreateDayMenus < ActiveRecord::Migration
  def change
    create_table :day_menus do |t|
      t.integer :day_id

      t.timestamps null: false
    end
  end
end
