Rails.application.routes.draw do
  get 'cart/index'
  get 'categories/index'
  get 'categories/show'
  root 'products#index'
  get '/about', to: 'about#index'
  get 'products/show'
  get '/cart', to: 'cart#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :products, only: %i[index show] do
    collection do
      get "search"
      get "recently_added"
      get "recently_updated"
    end
    post 'add_to_cart', on: :member
    delete 'remove_from_cart/:id', to: 'products#remove_from_cart', on: :member, as: :remove_from_cart
  end
  resources :categories, only: %i[index show]
  resources :cart, only: [:index, :destroy] do
    delete :remove_product, on: :member
  end

  # Add a route for the checkout action
  get '/checkout', to: 'checkout#new', as: 'checkout'
end
