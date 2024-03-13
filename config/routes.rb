Rails.application.routes.draw do
  devise_for :users
  root "boats#index"
  resources :boats, except: :index
  resources :rentals, only: [:index,:create, :show, :update]
  get "/myboats", to: "boats#my_boats", as: "myboats"
end
