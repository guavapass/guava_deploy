Rails.application.routes.draw do

  namespace :door_event do
    resources :opened, only: [:index]
    resources :closed, only: [:index]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
