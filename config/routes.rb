Rails.application.routes.draw do
  devise_for :users
  root "boats#index"
  resources :boats, except: :index
  resources :rentals, only: [:index,:create, :update]
  get "/myboats", to: "boats#my_boats", as: "myboats"
  delete "/myboats/:id", to: "boats#delete_my_boat", as: "delete_my_boat"

end
