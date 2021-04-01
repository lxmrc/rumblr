Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "registrations",
    sessions: "sessions"
  }
  get '/users/:id', to: 'users#show', as: :user
  root to: 'pages#home'
  resources :posts 
  post '/post/:id/like', to: 'likes#create', as: :like_post
  delete '/post/:id/like', to: 'likes#destroy', as: :unlike_post
end
