ActiveAdmin.register Item do
  config.per_page = 25

  permit_params :menu_id, :name, :price

  index do
    column :id
    column :name
    column :menu, sortable: 'menu_id'
    column :price
    column :created_at
    column :updated_at
    actions
  end
end
