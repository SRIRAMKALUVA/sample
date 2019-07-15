Rails.application.routes.draw do

  # namespace :api, format: :json do
    namespace :api do
    resources :users, except: [:new, :edit]
  end
  resources :test, only: :index

  get "dashboard", to: 'homes#index'
  resources :users do
    member do
      get :make_admin
    end
  end
  get "signup", to: "users#new"
  get "login", to: "users#login"
  get '/signin', to: redirect('/login')
  put "validate_user", to: "users#validate_user"
  delete "logout", to: "users#logout"
  get "add_articles", to: "users#create_article"
  post "post_article", to: "users#post_article"

  root to: "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
