Rails.application.routes.draw do
  devise_for :users
  root 'events#index'
  
  resources :users
  resources :events do
    member do
      get 'rsvp'
    end
  end
end
