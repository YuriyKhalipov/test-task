Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :orders
  root "orders#index"

  #get '/orders', to: 'orders#index'

  #get '/orders/new', to: 'orders#new'

  #get '/orders/:id', to: 'orders#show'

  #post '/orders', to: 'orders#create'
end
