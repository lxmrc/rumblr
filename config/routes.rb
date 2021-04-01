Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: { 
    registrations: "registrations",
    sessions: "sessions"
  }

  get '/users/:id', to: 'users#show', as: :user

  resources :posts do
    resources :comments
  end

  post '/post/:id/like', to: 'likes#create', as: :like_post
  delete '/post/:id/like', to: 'likes#destroy', as: :unlike_post
end
