Rails.application.routes.draw do
  get "user_checkouts/checkout"
  get "user_checkouts/create"
  devise_for :users
  get "checkouts/new"
  get "checkouts/create"
  get "cart_items/index"
  get "cart_items/create"
  get "cart_items/destroy"
  get "pages/show"
  resources :beats
  resources :orders, only: [:index]
resources :categories, only: [:index, :show]
resources :cart_items, only: [:create, :destroy] do
  patch :update_quantity, on: :collection
end


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/pages/:id", to: "pages#show", as: :page
  get "/about", to: "pages#show", defaults: { id: "About" }, as: :about
  get "/contact", to: "pages#show", defaults: { id: "Contact" }, as: :contact
  get "/cart", to: "cart_items#index", as: :cart
  get '/checkout', to: 'checkouts#checkout', as: 'checkout'
post "/checkout", to: "checkouts#create", as: :submit_checkout
get '/user_checkout', to: 'user_checkouts#checkout'
post '/user_checkout', to: 'user_checkouts#create', as: 'submit_user_checkout'
get '/my_orders', to: 'orders#index', as: :user_orders


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "beats#index"

end
