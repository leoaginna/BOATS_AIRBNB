Rails.application.routes.draw do
  root "boats#index"
  resources :boats, except: :index do
    resources :rentals, only: [:new, :create, :edit, :update, :delete]
  end
  resources :rentals, only: [:index, :show]
end
