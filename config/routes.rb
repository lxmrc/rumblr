Rails.application.routes.draw do
  root to: "pages#home"
  get "/about", to: "pages#about"

  devise_for :users, controllers: {
    registrations: "registrations",
    sessions: "sessions"
  }

  get "/users/:id", to: "users#show", as: :user
  get "/feed", to: "users#feed", as: :user_feed

  resources :posts do
    resources :comments
  end

  resources :users do
    member do
      get :following, :followers 
    end
  end


  resources :relationships,       only: [:create, :destroy]

  post "/post/:id/like", to: "likes#create", as: :like_post
  delete "/post/:id/like", to: "likes#destroy", as: :unlike_post

  get "/post/:id/reblog", to: "posts#new_reblog", as: :new_reblog
  post "/post/:id/reblog", to: "posts#create_reblog", as: :reblog_post
end
