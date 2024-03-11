Rails.application.routes.draw do
  get 'rentals/create'
  get 'rentals/new'
  get 'rentals/edit'
  get 'rentals/update'
  get 'rentals/cancel'
  get 'boats/index'
  get 'boats/new'
  get 'boats/create'
  get 'boats/edit'
  get 'boats/update'
  get 'boats/delete'
  devise_for :users
  root "boats#index"
  resources :boats, except: :index do
    resources :rentals, only: [:new, :create, :edit, :update, :cancel]
  end
  resources :rentals, only: [:index, :show]
end
