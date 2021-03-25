Rails.application.routes.draw do
  devise_for :users
  get '/users/:id', to: 'users#show'
  root to: 'pages#home'
end
