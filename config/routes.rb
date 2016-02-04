Rails.application.routes.draw do
  devise_for :users

  root 'briefcases#index'

  resources :briefcases
end
