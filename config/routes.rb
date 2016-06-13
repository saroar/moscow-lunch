Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'registrations' }

  root 'dashboard#home'
  get 'week_day_menu' => 'dashboard#week_day_menu'

  resources :orders

  namespace :api, defaults: { format: :json } do
    resources :orders, only: :index
  end
end
