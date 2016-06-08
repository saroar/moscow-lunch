Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#home'
  get 'week_day_menu' => 'dashboard#week_day_menu'
end
