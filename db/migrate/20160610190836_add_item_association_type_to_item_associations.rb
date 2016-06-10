class AddItemAssociationTypeToItemAssociations < ActiveRecord::Migration
  def change
    add_column :item_associations, :item_association_type, :string
  end
end
