ActiveAdmin.register Order do
  actions :all, except: [:new, :edit]
  config.per_page = 20

  index do
    column :id
    column :user
    column :organization
    column :created_at
    column :updated_at
    column :total
    actions
  end
end
