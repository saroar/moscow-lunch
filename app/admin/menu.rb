ActiveAdmin.register Menu do
  config.per_page = 10

  permit_params :name
end
