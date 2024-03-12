Rails.application.routes.draw do
  devise_for :users
  root "boats#index"
  resources :boats do
    resources :rentals, only: [:create]
  end
  resources :rentals, only: [:index, :show, :edit, :update, :cancel]
  get "/myboats", to: "boats#my_boats", as: "myboats"
end
