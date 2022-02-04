require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  get '/admin/orders/:id/status', to: 'admin/orders#status', as: :status_admin_orders
  ActiveAdmin.routes(self)

  resources :orders

  root "orders#new"
end
