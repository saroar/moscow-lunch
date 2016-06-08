Rails.application.routes.draw do
  root 'dashboard#home'
  devise_for :users
end
