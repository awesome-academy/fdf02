Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    resources :products
    get "/home" , to: "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    namespace :admin do
      root to: "users#index"
      get "/listcates" , to: "categories#index"
      get "/listproducts" , to: "products#index"
      get "/listorders" , to: "orders#index"
      resources :orders
      resources :categories
      resources :users
      resources :products
    end
    resources :carts
    get "/carts_show", to: "carts#show"
    get "/orders_show", to: "orders#show"
    get "/suggests_show", to: "suggests#show"
    delete "/destroy_cart", to: "carts#destroy"
    delete "/cart_delete_item", to: "carts#cart_delete_item"
    put "/carts_update", to: "carts#cart_update_item"
    get "/checkout", to: "carts#checkout"
    get "/products", to: "products#index"
    get "/about", to: "static_pages#about"
    get "/new_suggests", to: "suggests#index"
    resources :suggests
    resources :orders
    resources :order_details
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
