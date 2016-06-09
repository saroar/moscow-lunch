ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation

  index do
    column :id
    column :email
    column :name
    column :roles do |user|
      user.roles.collect {|c| c.name }.to_sentence
    end
    column :uid
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
