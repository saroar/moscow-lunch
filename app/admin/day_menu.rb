ActiveAdmin.register DayMenu do
  config.per_page = 20

  filter :day_id, as: :select, collection: Date::DAYNAMES.zip((0..7).to_a)
  filter :created_at, as: :date_range

  permit_params :day_id, item_ids: []

  index do
    column :id
    column "Day", sortable: 'day_id' do |day_menu|
      Date::DAYNAMES[day_menu.day_id]
    end
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Day Menu" do
      f.input :day_id, as: :radio, collection: Date::DAYNAMES.zip((0..7).to_a)
      Menu.all.each do |m|
        f.input :items, :label => "Items [ #{m.name} ]", as: :check_boxes, collection: Item.where(menu: m)
      end
    end
    f.actions
  end
end
