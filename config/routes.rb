Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "registrations",
    sessions: "sessions"
  }
  get '/users/:id', to: 'users#show', as: :user
  root to: 'pages#home'
  resources :posts
end
