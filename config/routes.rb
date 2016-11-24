Rails.application.routes.draw do
  post "/rate" => "rater#create", :as => "rate"

  root "static_pages#home"

  devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  namespace :admin do
    root :to => "categories#index", as: :root
    resources :categories
    resources :books
  end
  resources :categories
  resources :books do
    resources :reviews do
      resources :comments
    end
  end
end
