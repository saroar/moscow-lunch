Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root 'dashboard#home'
  get 'week_day_menu' => 'dashboard#week_day_menu'

  resources :orders
end
