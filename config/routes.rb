Rails.application.routes.draw do

  resources :visits, only: [:index]

  namespace :door_event do
    resources :opened, only: [:create]
    resources :closed, only: [:create]
  end

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
