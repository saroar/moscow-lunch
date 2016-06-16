class RemoveUserIdToOrganizations < ActiveRecord::Migration
  def change
    remove_column :organizations, :user_id, :integer
  end
end
