Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home" , to: "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    namespace :admin do
      root to: "users#index"
      get "/listcates", to: "categories#index"
      get "/listproducts", to: "products#index"
      resources :categories
      resources :users
      resources :products
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
