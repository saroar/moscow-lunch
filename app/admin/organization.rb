ActiveAdmin.register Organization do
  config.per_page = 30

  permit_params :name
end
