Rails.application.routes.draw do

  namespace :door_event do
    resources :opened, only: [:create]
    resources :closed, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
