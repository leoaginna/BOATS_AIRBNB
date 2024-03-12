gcRails.application.routes.draw do
  devise_for :users
  root "boats#index"
  resources :boats, except: :index do
    resources :rentals, only: [:create]
  end
  resources :rentals, only: [:index, :update, :cancel]
end
