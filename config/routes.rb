Rails.application.routes.draw do
  # Devise routes
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Main Pages
  get "/pages/:id", to: "pages#show", as: :page
  get "/about", to: "pages#show", defaults: { id: "About" }, as: :about
  get "/contact", to: "pages#show", defaults: { id: "Contact" }, as: :contact

  # Beats
  resources :beats
  resources :categories, only: [:index, :show]
  root "beats#index"

  # Cart
  get "/cart", to: "cart_items#index", as: :cart
  resources :cart_items, only: [:create, :destroy] do
    patch :update_quantity, on: :collection
  end

  # Guest Checkout
  get "/checkout", to: "checkouts#checkout", as: :checkout
  post "/checkout", to: "checkouts#create", as: :submit_checkout

  # Authenticated User Checkout
  get '/user_checkout', to: 'user_checkouts#checkout'
  post '/user_checkout', to: 'user_checkouts#create', as: :submit_user_checkout

  # ✅ Stripe Success/Cancel Routes for User Checkout
  get 'checkout/success', to: 'user_checkouts#success', as: :checkout_success
get 'checkout/cancel', to: 'user_checkouts#cancel', as: :checkout_cancel


  # Orders
  resources :orders, only: [:index]
  get '/my_orders', to: 'orders#index', as: :user_orders

  # Health Check
  get "up" => "rails/health#show", as: :rails_health_check
end
