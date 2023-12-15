Rails.application.routes.draw do
  get 'cart/index'
  get 'categories/index'
  get 'categories/show'
  root 'products#index'

  get '/about', to: 'about#index'
  get '/cart', to: 'cart#index'
  get '/checkout', to: 'checkout#index', as: 'checkout'
  get '/checkout/success', to: 'checkout#success', as: 'success_path'
  devise_for :customers

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  resources :products, only: %i[index show] do
    collection do
      get "search"
      get "recently_added"
      get "recently_updated"
    end
    post 'add_to_cart', on: :member
    delete 'remove_from_cart/:id', to: 'products#remove_from_cart', on: :member, as: :remove_from_cart
    patch 'update_cart/:id', to: 'products#update_cart', on: :member, as: :update_cart
  end

  resources :categories, only: %i[index show]

  resources :checkout, only: [] do
    post 'confirm_checkout', on: :collection
  end
end
